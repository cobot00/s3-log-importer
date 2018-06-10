require 'access_log'
require 'insert_transaction'

class AccessLogImporter
  COLUMNS = %w[
    uid http_method path summary_key
    device_type os os_version browser browser_version host_name
  ].freeze

  def import(date)
    proc_start_at = Time.zone.now
    Rails.logger.info("date: #{date}, proc_start_at: #{proc_start_at}")

    deleted_count = AccessLog.delete_by_date(date)
    Rails.logger.info("deleted: #{deleted_count}")

    bucket = AWS::ACCESS_LOG_BUCKET
    directory = "access/#{date.strftime('%Y/%m/%d')}"

    client = s3_client(AWS::ACCESS_KEY_ID, AWS::SECRET_ACCESS_KEY, AWS::REGION)

    objects = client.list_objects(bucket: bucket, prefix: directory).contents
    Parallel.each(objects, in_threads: CONSTANTS::THREAD_COUNT) do |object|
      start_at = Time.zone.now
      contents = client.get_object(bucket: bucket, key: object.key).body.read
      Rails.logger.info("#{object.key} - #{(Time.zone.now - start_at) * 1000} ms")

      records = read(contents)
      Rails.logger.info("#{object.key} - count: #{records.size}")

      access_logs = records.map do |r|
        params = COLUMNS.map { |c| [c, r[c]] }.to_h
        params[:requested_at] = Time.zone.at(r['time'])

        AccessLog.new(params)
      end

      transaction = InsertTransaction.new(AccessLog)
      access_logs.each { |access_log| transaction.push(access_log) }
      transaction.flush
    end

    Rails.logger.info("#{objects.size} files imported - #{format('%.1f', (Time.zone.now - proc_start_at) * 1000)}ms")
  end

  private

  def s3_client(aws_key, aws_secret, region)
    Aws.config.update({
      region: region,
      credentials: Aws::Credentials.new(aws_key, aws_secret)
    })
    Aws::S3::Client.new
  end

  def read(contents)
    IO.pipe do |reader, writer|
      writer.binmode
      begin
        writer.write(contents)
      rescue
        writer.close
      end

      log = Zlib::GzipReader.new(reader).read
      lines = log.split("\n")
      lines.map { |line| JSON.parse(line) }
    end
  end
end

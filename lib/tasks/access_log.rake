namespace :access_log do
  desc 'import access log from S3'
  task import: :environment do
    Rails.logger.info('import access log from S3 start')

    AccessLogImporter.new.import(Time.zone.yesterday)

    Rails.logger.info('import access log from S3 end')
  end

  desc 'import access log from S3 for specified period'
  task :import_specified_period, [:start_date, :end_date] => :environment do |task, args|
    start_at = Time.zone.now

    Rails.logger.info('import access log from S3 start for specified period start')
    Rails.logger.info("start_date: #{args.start_date}, end_date: #{args.end_date}")

    unless args.start_date
      Rails.logger.error('require argument: start_date and end_date')
      raise ArgumentError.new('require argument: start_date and end_date')
    end
    unless args.end_date
      Rails.logger.error('require argument: end_date')
      raise ArgumentError.new('require argument: end_date')
    end

    start_date = Time.zone.parse(args.start_date).to_date
    end_date = Time.zone.parse(args.end_date).to_date

    diff_days = (end_date - start_date).to_i
    if diff_days.negative?
      Rails.logger.error('start_date and end_date are reversed')
      raise ArgumentError.new('start_date and end_date are reversed')
    end

    range = 0..diff_days
    range.each do |n|
      date = start_date + n.day
      AccessLogImporter.new.import(date)
    end

    Rails.logger.info('import access log from for specified period S3 end')
  end
end

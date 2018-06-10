namespace :access_log do
  desc 'import access log from S3'
  task import: :environment do
    Rails.logger.info('import access log from S3 start')
    Rails.logger.info('import access log from S3 end')
  end
end

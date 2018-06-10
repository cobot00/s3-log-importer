Rails.application.configure do
  config.cache_classes = true

  config.eager_load = true

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  config.active_storage.service = :local

  config.log_level = :info

  config.log_tags = [:request_id]

  config.action_mailer.perform_caching = false

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify

  config.log_formatter = ::Logger::Formatter.new
  if ENV['RAILS_LOG_TO_STDOUT'].present?
    config.logger = ActiveSupport::Logger.new(STDOUT)
    config.logger.formatter = Beautiful::Log::Formatter.new
  end

  config.active_record.dump_schema_after_migration = false
end
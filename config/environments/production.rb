Rails.application.configure do
  config.cache_classes = true

  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = true

  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  config.assets.compile = false

  config.force_ssl = true

  config.log_level = :debug

  config.log_tags = [:request_id]

  config.action_mailer.perform_caching = false

  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = { host: 'http://54.199.24.92' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: 'smtp.gmail.com',
    domain: 'gmail.com',
    port: 587,
    user_name: Rails.application.credentials.gmail[:user_name],
    password: Rails.application.credentials.gmail[:password],
    authentication: :login,
    enable_starttls_auto: true
  }

  config.active_record.dump_schema_after_migration = false
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new
  config.eager_load = true

  if ENV['RAILS_LOG_TO_STDOUT'].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end
end

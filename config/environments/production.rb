Rails.application.configure do
  config.cache_classes = true

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  config.assets.compile = false

  config.active_storage.service = :amazon

  config.force_ssl = true

  config.log_level = :debug

  config.log_tags = [ :request_id ]

  config.action_mailer.perform_caching = false

  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.delivery_method = :smtp

  host = 'https://sample-app00.herokuapp.com'
  config.action_mailer.default_url_options = { host: host }
  ActionMailer::Base.smtp_settings = {
    :port           => ENV['MAILGUN_SMTP_PORT'],
    :address        => ENV['MAILGUN_SMTP_SERVER'],
    :user_name      => ENV['MAILGUN_SMTP_LOGIN'],
    :password       => ENV['MAILGUN_SMTP_PASSWORD'],
    :domain         => host,
    :authentication => :plain,
  }

  config.active_record.dump_schema_after_migration = false
  
  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify

  config.log_formatter = ::Logger::Formatter.new

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end
end

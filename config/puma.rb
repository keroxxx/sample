max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count
# port        ENV.fetch("PORT") { 3000 }
bind "unix://#{Rails.root}/tmp/sockets/puma.sock"
environment ENV.fetch("RAILS_ENV") { ENV['RACK_ENV'] || "production" }
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }
workers ENV.fetch("WEB_CONCURRENCY") { 2 }
preload_app!
plugin :tmp_restart
before_fork do
  PumaWorkerKiller.config do |config|
    config.ram           = 1024
    config.frequency     = 5 * 60
    config.percent_usage = 0.9
    config.rolling_restart_frequency = 24 * 3600
    config.reaper_status_logs = true
  end
  PumaWorkerKiller.start
  ActiveRecord::Base.connection_pool.disconnect! if defined?(ActiveRecord)
end
on_worker_boot do
    ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end
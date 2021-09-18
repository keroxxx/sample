environment "production"

# UNIX Socketへのバインド
tmp_path = "#{File.expand_path("../../..", __FILE__)}/tmp"
bind "unix://#{tmp_path}/sockets/puma.sock"

# スレッド数とWorker数の指定
threads 3, 3
workers 2
preload_app!

# デーモン化の設定
daemonize
pidfile "#{tmp_path}/pids/puma.pid"
stdout_redirect "#{tmp_path}/logs/puma.stdout.log", "#{tmp_path}/logs/puma.stderr.log", true

# rails restartコマンドが使えます。
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
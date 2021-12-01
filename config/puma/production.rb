environment 'production'

# UNIX Socketへのバインド
tmp_path = "#{File.expand_path('../..', __dir__)}/tmp"
bind "unix://#{tmp_path}/sockets/puma.sock"

# スレッド数とWorker数の指定
threads 3, 3
workers 2
preload_app!

pidfile "#{tmp_path}/pids/puma.pid"

# rails restartコマンドが使えます。
plugin :tmp_restart

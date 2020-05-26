# config/unicorn_socmedreg.rb
worker_processes Integer(ENV["WEB_CONCURRENCY"] || 5)
timeout 15
preload_app true

APP_PATH = File.expand_path '../../', __FILE__
APP_NAME='socmedreg'
working_directory APP_PATH

listen "/tmp/.#{APP_NAME}sock", :backlog => 64
listen 3000, :tcp_nopush => true

pid "#{APP_PATH}/unicorn_#{APP_NAME}.pid"
stderr_path "/#{APP_PATH}/log/smr.stderr.log"
stdout_path "/#{APP_PATH}/log/smr.stdout.log"

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
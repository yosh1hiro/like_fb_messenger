worker_processes 1

application_path = '/var/www/fi_chat'
current_path = "#{application_path}/current"
shared_path  = "#{application_path}/shared"

listen File.expand_path('unicorn.sock', "#{application_path}/shared/tmp/sockets")
pid File.expand_path('unicorn.pid', "#{shared_path}/tmp/pids")

stderr_path File.expand_path('unicorn_error.log', "#{shared_path}/log")
stdout_path File.expand_path('unicorn.log', "#{shared_path}/log")
preload_app true

before_fork do |server, worker|
  ENV['BUNDLE_GEMFILE'] = "#{current_path}/Gemfile"
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("WINCH", File.read(old_pid).to_i)
      Thread.new {
        sleep 15
        Process.kill("KILL", File.read(old_pid).to_i)
      }
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

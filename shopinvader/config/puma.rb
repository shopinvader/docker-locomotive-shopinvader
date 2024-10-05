# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.
#
threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
#
port        ENV.fetch("PORT") { 3000 }

# Specifies the `environment` that Puma will run in.
#
environment ENV.fetch("RAILS_ENV") { "development" }

before_fork do
  require 'puma_worker_killer'
  PumaWorkerKiller.config do |config|
    config.ram        = Integer(ENV['PUMA_MAX_RAM'] || 4096)
    config.frequency  = 60
    config.rolling_restart_frequency = 12 * 3600
  end
  PumaWorkerKiller.start
end

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked webserver processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
#
# workers ENV.fetch("WEB_CONCURRENCY") { 2 }

threads ENV['PUMA_MIN_THREADS'] || 0, ENV['PUMA_MAX_THREADS'] || 16
workers ENV['PUMA_WORKERS'] || 2

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory.
#
# preload_app!

# increase worker timeout in development mode
if ENV['RAILS_ENV'] == 'development'
  puts "LOGGER: development => worker_timeout 3600"
  worker_timeout 3600
end

# expose PUMA control app if auth token
if ENV['PUMA_AUTH_TOKEN']
  activate_control_app 'tcp://0.0.0.0:9293', { auth_token: ENV['PUMA_AUTH_TOKEN'] }
end

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart

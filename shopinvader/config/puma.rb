# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.
#
max_threads_count = ENV.fetch("PUMA_MAX_THREADS") { 16 }
min_threads_count = ENV.fetch("PUMA_MIN_THREADS") { 0 }
threads min_threads_count, max_threads_count

# Specifies the `worker_timeout` threshold that Puma will use to wait before
# terminating a worker in development environments.
#
worker_timeout 3600 if ENV.fetch("RAILS_ENV", "development") == "development"

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
#
port ENV.fetch("PORT") { 3000 }

# Specifies the `environment` that Puma will run in.
#
environment ENV.fetch("RAILS_ENV") { "development" }


# Specifies the `pidfile` that Puma will use.
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked web server processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
#

workers ENV.fetch("PUMA_WORKERS") { 2 }

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory.
#
preload_app!

if ENV.fetch("RAILS_ENV") == "production"
    before_fork do
      require 'puma_worker_killer'
      PumaWorkerKiller.config do |config|
        config.ram        = Integer(ENV['PUMA_MAX_RAM'] || 4096)
        config.frequency  = 60
        config.rolling_restart_frequency = 12 * 3600
      end
      PumaWorkerKiller.start
  end
end


# expose PUMA control app if auth token
if ENV['PUMA_AUTH_TOKEN']
  activate_control_app 'tcp://0.0.0.0:9293', { auth_token: ENV['PUMA_AUTH_TOKEN'] }
end

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart

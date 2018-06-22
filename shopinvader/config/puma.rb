#!/usr/bin/env puma

# see documentation here https://github.com/puma/puma/blob/master/examples/config.rb

environment ENV['RAILS_ENV']
threads ENV['PUMA_MIN_THREADS'] || 0, ENV['PUMA_MAX_THREADS'] || 16
workers ENV['PUMA_WORKERS'] || 2

bind 'tcp://0.0.0.0:3000'
activate_control_app 'tcp://0.0.0.0:9293', { auth_token: ENV['PUMA_AUTH_TOKEN'] }

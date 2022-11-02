#!/bin/bash
set -euxo pipefail

bundle install --without development
mkdir -p tmp log
chown 9999:9999 tmp log
# a fake SECRET KEY is needed to build asset :'(
# https://github.com/rails/rails/issues/32947
SECRET_KEY_BASE=1 RAILS_ENV=production bundle exec rake assets:precompile
rm -rf log/* tmp/*

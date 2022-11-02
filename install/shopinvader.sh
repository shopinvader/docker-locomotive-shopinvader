#!/bin/bash
set -euxo pipefail

bundle install --without development
mkdir -p tmp log
chown 9999:9999 tmp log
RAILS_ENV=production bundle exec rake assets:precompile
rm -rf log/* tmp/*

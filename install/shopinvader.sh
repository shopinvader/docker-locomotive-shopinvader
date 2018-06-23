#!/bin/bash
set -eo pipefail

bundle install --without development
mkdir -p tmp log
chown 9999:9999 tmp log
bundle exec rake assets:precompile
rm -rf log/* tmp/*

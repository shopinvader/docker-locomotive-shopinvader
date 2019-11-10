#!/bin/bash
set -eo pipefail

rm -f shopinvader/Gemfile.lock
docky run bundle install
echo "update done, check result the run"
echo "./bump.sh"

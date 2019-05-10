#!/bin/bash
set -e
rm shopinvader/Gemfile.lock
docky run bundle install
git add shopinvader/Gemfile shopinvader/Gemfile.lock
TAG="v4.0.x-`date +%Y%m%d`"
MESSAGE="Automatic release $TAG"
git commit -m "$MESSAGE"
git tag -a "$TAG" -m "$MESSAGE"
echo "bump done, check result the run"
echo "git push origin master --tag"

#!/bin/bash
set -eo pipefail

git add shopinvader/Gemfile shopinvader/Gemfile.lock
TAG="v4.0.x-`date +%Y%m%d`"
MESSAGE="Automatic release $TAG"
git commit -m "$MESSAGE"
git tag "$TAG"
echo "bump done, check result the run"
echo "git push origin master --tag"

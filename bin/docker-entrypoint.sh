#!/bin/bash
set -e

# allow to customize the UID of the loco user,
# so we can share the same than the host's.
# If no user id is set, we use 999
USER_ID=${LOCAL_USER_ID:-999}

echo "Starting with UID : $USER_ID"
id -u loco &> /dev/null || useradd --shell /bin/bash -u $USER_ID -o -c "" -m loco

echo "Changing permissions on writable directory with UID : $USER_ID"
chown -R $USER_ID /usr/src/app/log
chown -R $USER_ID /usr/src/app/tmp
chown -R $USER_ID /usr/src/app/public/sites
chown -R $USER_ID /usr/src/app/public/uploaded_assets

exec "$@"

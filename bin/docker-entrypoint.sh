#!/bin/bash
set -e

# loco user will have the same uid as the user that own the directory log and tmp
USER_ID=$(stat -c %u /usr/src/app/log)

if [ $USER_ID -eq "0" ]
then
  echo "The owner of log volume can not be root user"
  exit 1
elif [ $USER_ID -ne $(stat -c %u /usr/src/app/tmp) ]
then
  echo "The owner of tmp and log file should be the same"
  exit 1
fi

echo "Starting with UID : $USER_ID"
id -u loco &> /dev/null || useradd --shell /bin/bash -u $USER_ID -o -c "" -m loco

echo "Changing permissions on /usr/src/app/public with UID : $USER_ID"
chown -R $USER_ID /usr/src/app

exec "$@"

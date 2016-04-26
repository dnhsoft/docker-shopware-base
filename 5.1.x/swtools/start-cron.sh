#!/bin/bash

if [ ! $SW_CRON -eq 1 ]; then
  exit 0
fi

echo "Starting shopware cron..."

tail -f /var/log/swcron.log &
tail -f /var/log/swcron-errors.log &

while true;
do
  /swtools/run-cron.sh 2>>/var/log/swcron-errors.log 1>>/var/log/swcron.log &
  sleep 2m
done


#!/bin/bash

if [ $SW_CRON -eq 1 ]; then
  echo "Starting system cron..."
  cron &
  tail -f /var/log/cron.log &
  tail -f /var/log/cron-errors.log &
fi

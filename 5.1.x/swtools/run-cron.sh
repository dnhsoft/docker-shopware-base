#!/bin/bash

echo "sw:cron:run..."
php /shopware/bin/console sw:cron:run

# restore the directories ownershop back to www-data
/swtools/prepare-dirs.sh

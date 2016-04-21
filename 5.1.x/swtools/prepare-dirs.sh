#!/bin/bash

cd /shopware

if [ ! -d ./files ]; then
    mv /swvolumes/files ./files
fi

if [ ! -d ./media ]; then
    mv /swvolumes/media ./media
fi

if [ ! -d ./var/log ]; then
    mv /swvolumes/log ./var/log
fi


chown -R www-data:www-data var files media  engine/Shopware/Plugins
chmod 775 -R var/log var/cache files media engine/Shopware/Plugins/Community
chmod 544 /shopware/bin/console

#!/bin/bash

cd /shopware

# unzip -n makes the unzip to skip overrwiting of existing files;
# then set the rights and preserve the directories to be mounted;

unzip -n -q shop.zip
rm shop.zip

if [ -d recovery ]; then
    mv recovery /swrecovery
fi

if [ -d install ]; then
    mv install /swinstall
fi

if [ -f demo.zip ]; then
    unzip demo.zip
    rm demo.zip
fi

mkdir -p /shopware/logs

chown -R www-data:www-data /shopware/

chmod 775 -R cache files logs media engine/Shopware/Plugins/Community

mv logs /swvolumes/logs
mv files /swvolumes/files
mv media /swvolumes/media
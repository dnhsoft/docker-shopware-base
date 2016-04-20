#!/bin/bash

cd /shopware

cp -R /swvolumes/log/. var/log
cp -R /swvolumes/files/. files
cp -R /swvolumes/media/. media

chown -R www-data:www-data var/log
chown -R www-data:www-data files
chown -R www-data:www-data media

chmod 775 -R var/log
chmod 775 -R files
chmod 775 -R media

rm -rf /swvolumes/log/
rm -rf /swvolumes/files/
rm -rf /swvolumes/media/

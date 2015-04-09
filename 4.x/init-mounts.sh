#!/bin/bash

cd /shopware

cp -R /swvolumes/logs/. logs
cp -R /swvolumes/files/. files
cp -R /swvolumes/media/. media

chown -R www-data:www-data logs
chown -R www-data:www-data files
chown -R www-data:www-data media

chmod 775 -R logs
chmod 775 -R files
chmod 775 -R media

rm -rf /swvolumes/logs/
rm -rf /swvolumes/files/
rm -rf /swvolumes/media/
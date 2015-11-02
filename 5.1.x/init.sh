#!/bin/bash

echo "Setup mounted directories"
/swtools/init-mounts.sh

/swtools/wait-mysql.sh

echo "Start importing database..."
/swtools/init-db.php
echo "Database imported."


cd /shopware/bin 
curl -s https://getcomposer.org/installer | php 
php console sw:generate:attributes 
php console sw:firstrunwizard:disable 
php console sw:theme:initialize 
cd -

chown www-data:www-data -R /shopware/var/cache/
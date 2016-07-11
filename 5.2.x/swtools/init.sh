#!/bin/bash

/swtools/wait-mysql.sh

echo "Start importing database..."
php /swtools/init-db.php 
echo "Database imported."


echo "Start shop initialization..."
/swtools/init-shop.sh
echo "Shop initialized."

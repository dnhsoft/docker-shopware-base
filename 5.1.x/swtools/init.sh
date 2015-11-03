#!/bin/bash

echo "Setup mounted directories"
/swtools/init-mounts.sh

/swtools/wait-mysql.sh

echo "Start importing database..."
/swtools/init-db.php
echo "Database imported."


echo "Start shop initialization..."
/swtools/init-shop.sh
echo "Shop initialized."

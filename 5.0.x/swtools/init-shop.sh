#!/bin/bash

cd /shopware/bin
curl -s https://getcomposer.org/installer | php
php console sw:generate:attributes
php console sw:firstrunwizard:disable
php console sw:theme:initialize

chown www-data:www-data -R /shopware/cache/
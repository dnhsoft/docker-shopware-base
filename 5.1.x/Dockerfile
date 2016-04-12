FROM tutum/apache-php

RUN apt-get update && apt-get install -y \
        wget \
        unzip \
        mysql-client


# Install Ioncube loader
RUN mkdir /ioncube && \
    cd /ioncube && \
    wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz && \
    tar xvf ioncube_loaders_lin_x86-64.tar.gz && \
    cd `php -i | grep extension_dir | cut -d' ' -f 5` && \
    cp /ioncube/ioncube/ioncube_loader_lin_5.5.so . && \
    echo zend_extension=ioncube_loader_lin_5.5.so > /etc/php5/apache2/conf.d/000-ioncube.ini && \
    rm -rf /ioncube/

RUN a2enmod rewrite 


ENV SWDB_USER admin
ENV SWDB_PASS 123456
ENV SWDB_DATABASE shopware
ENV SWDB_HOST db
ENV SWDB_PORT 3306
ENV SW_CRON 0

COPY assets/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY assets/config.php /shopware/config.php
COPY assets/php-custom.ini /etc/php5/apache2/conf.d/999-custom.ini

COPY swtools /swtools

RUN rm -rf /var/www/html && ln -s /shopware /var/www/html && \
    chmod a+x /swtools/* && \
    mkdir -p /swvolumes

ENV COMPOSER_HOME /shopware
WORKDIR /shopware

COPY assets/swcron /etc/cron.d/swcron
RUN chmod 0644 /etc/cron.d/swcron
RUN touch /var/log/cron.log /var/log/cron-errors.log
RUN sed -i "2i/swtools/start-cron.sh" /run.sh

ONBUILD COPY sql-data.php /swtools/sql-data.php
ONBUILD COPY download-shopware.sh /swtools/download-shopware.sh
ONBUILD RUN chmod a+x /swtools/*
ONBUILD RUN /swtools/download-shopware.sh
ONBUILD RUN /swtools/unzip-shopware.sh

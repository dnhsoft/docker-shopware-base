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
ENV SWSNIPPET_READ_FROM_DB 1
ENV SWSNIPPET_WRITE_TO_DB 1
ENV SWSNIPPET_READ_FROM_INI 0
ENV SWSNIPPET_WRITE_TO_INI 0
ENV SWSNIPPET_SHOW_SNIPPET_PLACE_HOLDER 0
ENV SWFRONT_NO_ERROR_HANDLER 0
ENV SWFRONT_THROW_EXCEPTIONS 0
ENV SWFRONT_DISABLE_OUTPUT_BUFFERING 0
ENV SWFRONT_SHOW_EXCEPTION 0
ENV SWPHPSETTINGS_DATE_TIMEZONE UTC



COPY assets/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY assets/config.php /shopware/config.php
COPY assets/php-custom.ini /etc/php5/apache2/conf.d/999-custom.ini

COPY swtools /swtools

RUN rm -rf /var/www/html && ln -s /shopware /var/www/html && \
    chmod a+x /swtools/* && \
    mkdir -p /swvolumes

ENV COMPOSER_HOME /shopware
WORKDIR /shopware

RUN touch /var/log/swcron.log /var/log/swcron-errors.log

# inject some commands in the run.sh file;
RUN sed -i "2i/swtools/start-cron.sh &" /run.sh
RUN sed -i "2i/swtools/prepare-dirs.sh" /run.sh


ONBUILD COPY sql-data.php /swtools/sql-data.php
ONBUILD COPY download-shopware.sh /swtools/download-shopware.sh
ONBUILD RUN chmod a+x /swtools/*
ONBUILD RUN /swtools/download-shopware.sh
ONBUILD RUN /swtools/unzip-shopware.sh

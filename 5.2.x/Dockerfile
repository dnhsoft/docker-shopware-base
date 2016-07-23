FROM dnhsoft/php:5.6-apache

RUN apt-get update && apt-get install -y \
        wget \
        zip \
        unzip \
        mysql-client \
	libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        php5-apcu \
    && docker-php-ext-install -j$(nproc) iconv mcrypt pdo_mysql \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd


# Install Ioncube loader
RUN mkdir /ioncube && \
    cd /ioncube && \
    wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz && \
    tar xvf ioncube_loaders_lin_x86-64.tar.gz && \
    cd `php -i | grep extension_dir | cut -d' ' -f 5` && \
    cp /ioncube/ioncube/ioncube_loader_lin_5.6.so . && \
    rm -rf /ioncube/


# a little bit of manual hack as apcu did not appear in the right folder
RUN cp  /usr/lib/php5/20131226/apcu.so  /usr/local/lib/php/extensions/no-debug-non-zts-20131226/apcu.so && \
    chown root:staff /usr/local/lib/php/extensions/no-debug-non-zts-20131226/apcu.so


RUN a2enmod rewrite 

RUN sed -i 's/www-data:x:33:33/www-data:x:1000:1000/g' /etc/passwd

ENV SWDB_USER root
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


# php variables
ENV SWPHP_UPLOAD_MAX_FILESIZE "64M"
ENV SWPHP_POST_MAX_FILESIZE "64M"
ENV SWPHP_MEMORY_LIMIT "512M"

# opcache variables
ENV SWPHP_OPCACHE_ENABLE 1
ENV SWPHP_OPCACHE_MEMORY_CONSUMPTION 128
ENV SWPHP_OPCACHE_INTERNED_STRINGS_BUFFER 8
ENV SWPHP_OPCACHE_ACCELERATED_FILES 10000
ENV SWPHP_OPCACHE_REVALIDATE_FREQ 5
ENV SWPHP_OPCACHE_FAST_SHUTDOWN 1

# other variables
ENV SWPHP_IONCUBE_ENABLE 1
ENV SWPHP_APCU_ENABLE 1



COPY assets/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY assets/config.php /shopware/config.php

COPY swtools /swtools

RUN rm -rf /var/www/html && ln -s /shopware /var/www/html && \
    chmod a+x /swtools/* && \
    mkdir -p /swvolumes

ENV COMPOSER_HOME /shopware
WORKDIR /shopware

RUN curl -s https://getcomposer.org/installer | php

RUN touch /var/log/swcron.log /var/log/swcron-errors.log

# inject some commands in the run.sh file;
RUN sed -i "3i/swtools/start-cron.sh &" /usr/local/bin/apache2-foreground
RUN sed -i "3i/swtools/prepare-dirs.sh" /usr/local/bin/apache2-foreground
RUN sed -i "3i/swtools/setup-php.sh" /usr/local/bin/apache2-foreground


ONBUILD COPY sql-data.php /swtools/sql-data.php
ONBUILD COPY download-shopware.sh /swtools/download-shopware.sh
ONBUILD RUN chmod a+x /swtools/*
ONBUILD RUN /swtools/download-shopware.sh
ONBUILD RUN /swtools/unzip-shopware.sh

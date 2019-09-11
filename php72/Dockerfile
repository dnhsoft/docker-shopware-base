FROM php:7.2-apache

ENV PHP_VERSION 7.2

RUN apt-get update && apt-get install -y \
        git \
        wget \
        unzip \
        mariadb-client \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libicu-dev \
        zlib1g-dev \
    && docker-php-ext-install -j$(nproc) iconv pdo pdo_mysql zip bcmath intl \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN pecl install apcu

RUN a2enmod rewrite

# useful for local development with mounted sources
RUN sed -i 's/www-data:x:33:33/www-data:x:1000:1000/g' /etc/passwd

COPY assets/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY assets/setup-php.sh /setup-php.sh
RUN chmod +x /setup-php.sh

RUN rm -rf /var/www/html && ln -s /shopware /var/www/html && \
    mkdir -p /swvolumes

ENV COMPOSER_HOME /shopware

#RUN curl -s https://getcomposer.org/installer | php


# some default values of php variables
ENV PHP_UPLOAD_MAX_FILESIZE "64M"
ENV PHP_POST_MAX_FILESIZE "64M"
ENV PHP_MEMORY_LIMIT "512M"
ENV PHP_MAX_EXECUTION_TIME "60"

# opcache variables
ENV PHP_OPCACHE_ENABLE 1
ENV PHP_OPCACHE_MEMORY_CONSUMPTION 128
ENV PHP_OPCACHE_INTERNED_STRINGS_BUFFER 8
ENV PHP_OPCACHE_ACCELERATED_FILES 10000
ENV PHP_OPCACHE_REVALIDATE_FREQ 5
ENV PHP_OPCACHE_FAST_SHUTDOWN 1
ENV PHP_SESSION_COOKIE_SECURE On

# other variables
ENV PHP_APCU_ENABLE 1



ENV SWDB_USER root
ENV SWDB_PASS 123456
ENV SWDB_DATABASE shopware
ENV SWDB_HOST db
ENV SWDB_PORT 3306
ENV SW_CRON 0
ENV SW_HTTPS on
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
ENV SWPHPSETTINGS_DISPLAY_ERRORS 1
ENV SWPHP_IONCUBE_ENABLE 0

ENV SWCSRFPROTECTION_FRONTEND 1
ENV SWCSRFPROTECTION_BACKEND 1
ENV SWFRONT_CHARSET "utf-8"
ENV SWHTTPCACHE_ENABLED 1
ENV SWHTTPCACHE_LOOKUP_OPTIMIZATION 1
ENV SWHTTPCACHE_DEBUG 0
ENV SWHTTPCACHE_DEFAULT_TTL 0
ENV SWHTTPCACHE_ALLOW_RELOAD 0
ENV SWHTTPCACHE_ALLOW_REVALIDATE 0
ENV SWHTTPCACHE_STALE_WHILE_REVALIDATE 2
ENV SWHTTPCACHE_STALE_IF_ERROR 0
ENV SWHTTPCACHE_CACHE_COOKIES "shop|currency|x-cache-context-hash"



# Inject some commands in the run.sh file in order to have a startup contron. 
# prepare-sw-on-startup.sh must be defined by the inheritant Docker images.
RUN sed -i "3i/swtools/prepare-sw-on-startup.sh" /usr/local/bin/apache2-foreground
RUN sed -i "3i/setup-php.sh" /usr/local/bin/apache2-foreground


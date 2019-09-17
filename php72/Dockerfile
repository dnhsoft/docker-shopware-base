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


#ENV COMPOSER_HOME /shopware
#RUN curl -s https://getcomposer.org/installer | php

# Install Ioncube loader
RUN mkdir /ioncube && \
    cd /ioncube && \
    wget https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz && \
    tar xvf ioncube_loaders_lin_x86-64.tar.gz && \ 
    cd `php -i | grep extension_dir | cut -d' ' -f 5` && \
    cp /ioncube//ioncube/ioncube_loader_lin_7.2.so . && \
    pwd && ls -la && \
    rm -rf /ioncube/


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
ENV PHP_OPCACHE_VALIDATE_ROOT 1

# other variables
ENV PHP_APCU_ENABLE 1


# Inject some commands in the run.sh file in order to have a startup contron. 
# prepare-sw-on-startup.sh must be defined by the inheritant Docker images.
RUN sed -i "3i/swtools/prepare-sw-on-startup.sh" /usr/local/bin/apache2-foreground
RUN sed -i "3i/setup-php.sh" /usr/local/bin/apache2-foreground


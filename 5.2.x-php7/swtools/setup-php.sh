#!/bin/bash

INI_DIR="/usr/local/etc/php/conf.d"

SHOPWARE_INI_FILE="$INI_DIR/shopware-custom.ini"

rm -f $SHOPWARE_INI_FILE

echo "upload_max_filesize=$SWPHP_UPLOAD_MAX_FILESIZE" >> $SHOPWARE_INI_FILE
echo "post_max_size=$SWPHP_POST_MAX_FILESIZE" >> $SHOPWARE_INI_FILE
echo "memory_limit=$SWPHP_MEMORY_LIMIT" >> $SHOPWARE_INI_FILE


OPCACHE_INI_FILE="$INI_DIR/opcache-custom.ini"

rm -f $OPCACHE_INI_FILE

if [ $SWPHP_OPCACHE_ENABLE == '1' ]; then
  echo "zend_extension=opcache.so" >> $OPCACHE_INI_FILE
  echo "opcache.enable=1" >> $OPCACHE_INI_FILE
  echo "opcache.memory_consumption=$SWPHP_OPCACHE_MEMORY_CONSUMPTION" >> $OPCACHE_INI_FILE
  echo "opcache.interned_strings_buffer=$SWPHP_OPCACHE_INTERNED_STRINGS_BUFFER" >> $OPCACHE_INI_FILE
  echo "opcache.max_accelerated_files=$SWPHP_OPCACHE_ACCELERATED_FILES" >> $OPCACHE_INI_FILE
  echo "opcache.revalidate_freq=$SWPHP_OPCACHE_REVALIDATE_FREQ" >> $OPCACHE_INI_FILE
  echo "opcache.fast_shutdown=$SWPHP_OPCACHE_FAST_SHUTDOWN" >> $OPCACHE_INI_FILE
fi

IONCUBE_INI_FILE="$INI_DIR/000-ioncube.ini"

rm -f $IONCUBE_INI_FILE

if [ $SWPHP_IONCUBE_ENABLE == '1' ]; then
  echo "zend_extension=ioncube_loader_lin_x86-64_7.0b7.so" >> $IONCUBE_INI_FILE
fi


APC_INI_FILE="$INI_DIR/apcu.ini"

if [ $SWPHP_APCU_ENABLE == '1' ]; then
  echo 'extension=apcu.so' > $APC_INI_FILE
fi
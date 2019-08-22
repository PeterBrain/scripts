#!/bin/bash

# cleanes the cache, log or upgrades your magento shop (except product image cache)
#
# ./magento_bin.sh <domain.tld> <mode: "cache", "index", "upgrade", "log", "db-log", "">

DOMAIN=$1
MODE=$2
ROOT_DIR="/var/www/${DOMAIN}"

cd ${ROOT_DIR}/web

if [ -z "${MODE}" ] || [ "${MODE}" == "upgrade" ]; then
  php bin/magento setup:upgrade
fi

if [ -z "${MODE}" ] || [ "${MODE}" == "upgrade" ] || [ "${MODE}" == "index" ]; then
  php bin/magento indexer:reindex
fi

if [ "${MODE}" == "log" ]; then
  rm var/log/*
  rm var/report/*
  rm var/session/*
fi

if [ "${MODE}" == "db-log" ]; then
  #TODO ## some sql statement I guess
fi

if [ -z "${MODE}" ]; then
  php bin/magento cache:clean
  php bin/magento cache:flush
fi

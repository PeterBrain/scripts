#!/bin/bash

DOMAIN=$1
DATABASE=$2
DB_ONLY=$3
EXCLUDE_DIR=$4
ROOT_DIR="/var/www/${DOMAIN}"
DATE=$(date '+%Y_%m_%d')

mysqldump --defaults-group-suffix=${DOMAIN} ${DATABASE} | gzip > ${ROOT_DIR}/backup/${DOMAIN}_${DATE}_${DATABASE}.sql.gz

if [ "${DB_ONLY}" != "true" ]; then
  tar $(if [ ! -z "${EXCLUDE_DIR}" ]; then echo --exclude=${ROOT_DIR}/web/${EXCLUDE_DIR}; fi) -zcf ${ROOT_DIR}/backup/${DOMAIN}_${DATE}.tar.gz ${ROOT_DIR}/web
fi

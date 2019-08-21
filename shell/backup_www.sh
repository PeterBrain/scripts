#!/bin/bash

# backup script for magento including database (.my.cnf for user and password settings)
#
# ./backup_www.sh <domain.tld> <mode: "db", "dir", "full"> <database_name> <exclude_folder_path>
#
# how to use (cronjob)
# @weekly /bin/bash /path/to/script/backup_www.sh ...

DOMAIN=$1
MODE=$2
DATABASE=$3
EXCLUDE_DIR=$4
ROOT_DIR="/var/www/${DOMAIN}"
DATE=$(date '+%Y-%m-%d_%H-%M-%S')

if ([ -z "${MODE}" ] || [ "${MODE}" == "full" ] || [ "${MODE}" == "db" ]) && [ -n "${DATABASE}" ]; then
  echo -e "\nBacking up Database\n"
  mysqldump --defaults-group-suffix=${DOMAIN} ${DATABASE} | gzip > ${ROOT_DIR}/backup/${DOMAIN}_${DATE}_${DATABASE}.sql.gz

  # clean db_logs - implement in magento_bin.sh
fi

if [ -z "${MODE}" ] || [ "${MODE}" == "full" ] || [ "${MODE}" == "dir" ]; then
  echo -e "\nClearing cache\n"
  ./magento_bin.sh ${DOMAIN} cache > /dev/null

  echo -e "\nBacking up Files\n"
  tar $(if [ ! -z "${EXCLUDE_DIR}" ]; then echo --exclude=${ROOT_DIR}/web/${EXCLUDE_DIR}; fi) -zcf ${ROOT_DIR}/backup/${DOMAIN}_${DATE}.tar.gz ${ROOT_DIR}/web

  echo -e "\nCleaning log files\n"
  ./magento_bin.sh ${DOMAIN} log
fi

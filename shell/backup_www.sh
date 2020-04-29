#!/usr/bin/env bash

# backup script for magento including database (.my.cnf for user and password settings)
#
# ./backup_www.sh <domain.tld> <mode: "db", "dir", "full"> <database_name> <magento_version: m1 or m2> <backup_folder> <webspace_folder>
#
# how to use (cronjob)
# @weekly /bin/bash /path/to/script/backup_www.sh ...

DOMAIN=$1
MODE=$2
DATABASE=$3
VERSION=$4
BACKUP_DIR=$5
WEBSPACE_DIR=$6

ROOT_DIR="/var/www/${DOMAIN}"
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
DATE=$(date '+%Y-%m-%d_%H-%M-%S')

if { [ -z "${MODE}" ] || [ "${MODE}" == "full" ] || [ "${MODE}" == "db" ]; } && [ -n "${DATABASE}" ]; then
  printf "Cleaning Database log\n"
  cd "${BASE_DIR}" || exit
  ./magento_bin.sh "${DOMAIN}" "${VERSION}" "${WEBSPACE_DIR}" db-log

  printf "Backing up Database\n"
  cd "${ROOT_DIR}" || exit

  mysqldump \
  --defaults-group-suffix="${DOMAIN}" "${DATABASE}" \
  | gzip > ./"${BACKUP_DIR}"/"${DOMAIN}"_"${DATE}"_"${DATABASE}".sql.gz
fi

if [ -z "${MODE}" ] || [ "${MODE}" == "full" ] || [ "${MODE}" == "dir" ]; then
  printf "Clearing cache\n"
  cd "${BASE_DIR}" || exit
  ./magento_bin.sh "${DOMAIN}" "${VERSION}" "${WEBSPACE_DIR}" cache > /dev/null

  printf "Cleaning log files\n"
  cd "${BASE_DIR}" || exit
  ./magento_bin.sh "${DOMAIN}" "${VERSION}" "${WEBSPACE_DIR}" log

  printf "Backing up Files\n"
  cd "${ROOT_DIR}" || exit

  if [ "$VERSION" == "m1" ]; then
    tar \
    --exclude=./"${WEBSPACE_DIR}"/media \
    --exclude=./"${WEBSPACE_DIR}"/var/{cache,log,report,session} \
    -zcf ./"${BACKUP_DIR}"/"${DOMAIN}"_"${DATE}".tar.gz ./"${WEBSPACE_DIR}"

  elif [ "$VERSION" == "m2" ]; then
    tar \
    --exclude=./"${WEBSPACE_DIR}"/.git \
    --exclude=./"${WEBSPACE_DIR}"/generated \
    --exclude=./"${WEBSPACE_DIR}"/pub/{media,static} \
    --exclude=./"${WEBSPACE_DIR}"/var/{cache,di,log,report,generation,page_cache,view_preprocessed,composer_home} \
    -zcf ./"${BACKUP_DIR}"/"${DOMAIN}"_"${DATE}".tar.gz ./"${WEBSPACE_DIR}"

  fi
fi

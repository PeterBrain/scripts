#!/bin/sh

##
## Author:    PeterBrain
## Reference: https://www.changeip.com/accounts/knowledgebase.php?action=displayarticle&id=34
## Script:    https://www.changeip.com/accounts/downloads.php
##
## Use in crontab (every 5 min): */5 *  * * * /path/to/ddns_changeIP.sh "<host>"
##
## Basic Authentication Credentials should be provided via .netrc file like this:
##
## machine <fqdn>
## login <user>
## password <password>
##

datetime() { ## date + time with specific format
  date +"%Y-%m-%d %H:%M:%S"
}

DIR="/var/log/cron/" ## log and temp file directory
HOST="$1"

if [ ! -d "${DIR}" ] ## no directory; e.g. first run
then
  mkdir "${DIR}"
  touch "${DIR}ip.tmp"
  touch "${DIR}changeIP_error.log"
  touch "${DIR}changeIP_success.log"
fi

PUB_IP=$(curl --silent "http://dyn.value-domain.com/cgi-bin/dyn.fcg?ip")
LAST_IP=$(cat "${DIR}ip.tmp")

if [ "${PUB_IP}" = "${LAST_IP}" ] ## ip changed?
then
  exit 0 ## nothing changed; exit
else
  RESPONSE=$( \
  curl \
    --netrc \
    --write-out '%{http_code}' \
    --silent \
    --output /dev/null \
    --head "https://nic.changeip.com/nic/update?hostname=${HOST}" \
  )

  if [ "${RESPONSE}" != 200 ] ## everything else than 200 is bad? or 2xx?
  then
    echo "$(datetime) Update failed: Error ${RESPONSE} - HOST:${HOST}" >> "${DIR}changeIP_error.log"
  else
    echo "$(datetime) Update successful: Code ${RESPONSE} - HOST:${HOST}" >> "${DIR}changeIP_success.log"
    echo "${PUB_IP}" > "${DIR}ip.tmp" ## store current ip in temp file
  fi
fi

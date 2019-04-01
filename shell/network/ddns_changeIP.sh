#!/bin/sh

##
## Author:    PeterBrain
## Reference: https://www.changeip.com/accounts/knowledgebase.php?action=displayarticle&id=34
## Script:    https://www.changeip.com/accounts/downloads.php
##
## Use in crontab (every 5 min): */5 *  * * * /path/to/ddns_changeIP.sh "<host>" "<username (base64 encoded)>" "<pass (base64 encoded)>"
##
## Base64 encoding is used to store credentials other than in plain text. Anybody with a basic understanding, is capable of decoding the string. But it is still better than plain text.
##

decode64() { ## decode base64 encoded string
  echo "$1" | base64 --decode # or -d
}

datetime() { ## date + time with specific format
  date +"%Y-%m-%d %H:%M:%S"
}

DIR="/var/log/cron/" ## log and temp file directory
HOST="$1"
USER=$(decode64 "$2")
PASS=$(decode64 "$3")

if [ ! -d "$DIR" ] ## no directory; e.g. first run
then
  mkdir "$DIR"
  touch "${DIR}ip.tmp"
fi

UPDATE_DNS="https://nic.changeip.com/nic/update?u=$USER&p=$PASS&hostname=$HOST" #&ip=$IP&set=$SET&offline=$OFFLINE
PUB_IP=$(curl --silent "http://dyn.value-domain.com/cgi-bin/dyn.fcg?ip")
LAST_IP=$(cat "${DIR}ip.tmp")

if [ "$PUB_IP" = "$LAST_IP" ] ## ip changed?
then
  exit 0 ## nothing changed; exit
else
  RESPONSE=$(curl -o /dev/null --silent --head --write-out '%{http_code}\n' "$UPDATE_DNS") ## update dns

  if [ "$RESPONSE" != 200 ] ## everything else than 200 is bad? or 2xx?
  then
    echo "$(datetime) Update failed: Error $RESPONSE - HOST:$HOST USER:$USER" >> "${DIR}changeIP_error.log"
  else
    #echo "$(datetime) Update success: Code $RESPONSE - HOST:$HOST USER:$USER" >> "${DIR}changeIP_success.log"
    echo "$PUB_IP" > "${DIR}ip.tmp" ## store current ip in temp file
  fi
fi

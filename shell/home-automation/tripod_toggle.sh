#!/usr/bin/env bash

declare -i response=0
declare -i retries=0

ip="192.168.24.195"
resource="rf3"

uri_status="$(curl --silent --max-time 3 "http://${ip}/${resource}/status/io" | sed -e '/<[^>]*>/g' | tr -d '\n' | tr -d '\r')" # check status & remove html tags + special characters

if [ "${uri_status}" = "0" ]; then
  uri="http://${ip}/${resource}/on"
else
  uri="http://${ip}/${resource}/off"
fi

while [ "${response}" != 200 ] && [ "${retries}" -lt 3 ]; do # try 3 times
  response="$(curl --head --write-out "%{http_code}" --silent --output /dev/null --max-time 3 "${uri}")"
  retries="${retries}"+1
done

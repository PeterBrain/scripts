#!/usr/bin/env bash

declare -i response=0
declare -i retries=0
uri="http://192.168.24.195/rf3/off"

while [ "${response}" != 200 ] && [ "${retries}" -lt 3 ]; do
  response="$(curl --head --write-out "%{http_code}" --silent --output /dev/null --max-time 3 "${uri}")"
  retries="${retries}"+1
done

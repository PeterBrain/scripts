#!/bin/sh

response=0
retries=0

while [ "${response}" != 200 -a "${retries}" -lt 3 ]
do
  response=$(curl --head --write-out %{http_code} --silent --output /dev/null --max-time 3 "http://192.168.24.195/rf3/off")
  let retries=$retries+1
done

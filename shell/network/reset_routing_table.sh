#!/bin/sh
## reset routing table on macOS

#netstat -r ## display routing table

for i in {0..5}; do
  sudo route -n flush # several times
done

sudo ifconfig en0 down # bring interface down

sleep 1

sudo ifconfig en0 up # bring interface up again

#!/bin/bash

## reset routing table on macOS

# flush dns
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder

#netstat -r ## display routing table

for i in {0..5}; do
  sudo route -n flush # several times
done

sudo ifconfig en0 down # bring interface down

sleep 1

sudo ifconfig en0 up # bring interface up again

osascript -e 'display notification "DNS flushed & routing table reset" with title "System"'

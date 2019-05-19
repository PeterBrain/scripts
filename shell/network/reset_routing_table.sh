#!/bin/sh
## reset routing table on macOS

sudo killall -HUP mDNSResponder # flush dns

#netstat -r ## display routing table

for i in {0..5}; do
  sudo route -n flush # several times
done

sudo ifconfig en0 down # bring interface down

sleep 1

sudo ifconfig en0 up # bring interface up again

osascript -e 'display notification "DNS flushed & routing table reset" with title "System"'

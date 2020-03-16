#!/bin/bash

dns_status=`networksetup -getdnsservers Wi-Fi`

if [ "$dns_status" != "There aren't any DNS Servers set on Wi-Fi." ]
then
  networksetup -getdnsservers Wi-Fi > ~/.dns_servers
  networksetup -setdnsservers Wi-Fi empty
  osascript -e 'display notification "emptied DNS servers" with title "System"'
else
  networksetup -setdnsservers Wi-Fi 1.1.1.1 1.0.0.1 2606:4700:4700::1111 2606:4700:4700::1001
  osascript -e 'display notification "set CloudFlare DNS servers" with title "System"'
fi

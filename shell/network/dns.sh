#!/bin/sh

dns_status=`networksetup -getdnsservers Wi-Fi`

if [ "$dns_status" != "There aren't any DNS Servers set on Wi-Fi." ]
then
  networksetup -getdnsservers Wi-Fi > ~/.dns_servers
  networksetup -setdnsservers Wi-Fi empty
else
  networksetup -setdnsservers Wi-Fi 1.1.1.1 1.0.0.1 2606:4700:4700::1111 2606:4700:4700::1001
fi

#!/bin/bash

printf "Change proxy setting for work\n\n"

networksetup -setwebproxy Ethernet 172.16.1.64 3128
networksetup -setsecurewebproxy Ethernet 172.16.1.64 3128

## Displays the current proxy settings
#networksetup -getwebproxy Ethernet
#networksetup -getsecurewebproxy Ethernet

read -p "Press enter to close this terminal and revert proxy settings"

networksetup -setwebproxy Ethernet off
networksetup -setsecurewebproxy Ethernet off

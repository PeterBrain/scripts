#!/bin/sh

#networksetup -getwebproxy Ethernet
networksetup -setwebproxy Ethernet 172.16.1.64 3128
networksetup -setsecurewebproxy Ethernet 172.16.1.64 3128

#networksetup -getwebproxy Ethernet
#networksetup -getsecurewebproxy Ethernet

read -p "Press any key to close this terminal"

networksetup -setwebproxy Ethernet off
networksetup -setsecurewebproxy Ethernet off
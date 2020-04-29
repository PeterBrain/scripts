#!/usr/bin/env bash

ifconfig en0 | awk '/ether/{print $2}' > .reset_mac_address_en0
ifconfig en1 | awk '/ether/{print $2}' > .reset_mac_address_en1

printf "\nThis script will temporarily change your mac address to a random number until you reboot your device or run the script again.\n\n"

#old_mac_address="$(ifconfig en0 | awk '/ether/{print $2}')"
new_mac_address="$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//')"
interfaces="$(ifconfig | grep flags | awk -F: '{print $1;}')"

PS3="Choose the interface (or ctrl-c to quit): "
select interface in "$interfaces"
do
  printf "\nInterface %s will be changed to %s\n" "${interface}" "${new_mac_address}"
  read -rp "Press enter to accept (ctrl-c to deny): "

  sudo ifconfig "$interface" ether "$new_mac_address"

  printf "\nMAC-Address successfully changed.\n"
done

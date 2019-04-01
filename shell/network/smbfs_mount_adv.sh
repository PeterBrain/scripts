#!/bin/sh

en0=`ipconfig getifaddr en0`
en1=`ipconfig getifaddr en1`
SSID=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk -F': ' '/ SSID/ {print $2}')

username="guest"
hostname="10.0.0.10"
mount_path=/tmp/share
shares=("Public" "www$" "Peter$")
drives_school=("classes" "ITDaten")

drv_connect() {
  drives=$@
  for drive in ${drives[@]}
  do
    drive_mk=(${drive//$/})
    mkdir $mount_path/${drive_mk[0]}
    mount -t smbfs smb://$username@$hostname/$drive $mount_path/${drive_mk[0]}
  done
}

if [ -n "$en1" ] || [ -n "$en0" ]; then
  if [ $SSID = "Home" ]; then
    drv_connect ${shares[@]}
  #elif [ $SSID == "3WebCube_A1ED" ]; then
  else
    printf "\033[0;31mConnected with wrong Network: $SSID\n\033[0m"
  fi
fi

if [ -n "$en0" ]; then
  drv_connect ${shares[@]}
else
  printf "\033[0;31mNo ethernet cable connected\n\033[0m"
fi

#read -p "Press enter to close this terminal"

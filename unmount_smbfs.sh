#!/bin/sh
#Mount shared folders via smb
#admin:password

SSID=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk -F': ' '/ SSID/ {print $2}')

drives="Public www$ Peter$"

for drive in $drives
do

if [ "$SSID" = "Home" ]
then
	drive_mk=(${drive//$/})
	umount -t smbfs smb://guest@SVR-01/$drive /tmp/share/${drive_mk[0]}
	rmdir /tmp/share/${drive_mk[0]}
	
	echo "Connected to Network Drive: $drive"
else
	echo "Connected with the wrong Network: $SSID"
fi

done

rmdir /tmp/share
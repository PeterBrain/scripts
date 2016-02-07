#!/bin/sh
#Mount shared folders via smb
#admin:password WORKGROUP;
#mkdir /tmp/share/www
#mount -t smbfs smb://guest@SVR-01/www$ /tmp/share/www
#mkdir /tmp/share/peter
#mount -t smbfs smb://guest@SVR-01/Peter$ /tmp/share/peter

SSID=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk -F': ' '/ SSID/ {print $2}')

drives="Public www$ Peter$"
for drive in $drives
do

if [ "$SSID" = "Home" ]
then
	drive_mk=(${drive//$/})
	mkdir /tmp/share/${drive_mk[0]}
	mount -t smbfs smb://guest@SVR-01/$drive /tmp/share/${drive_mk[0]}
	
	echo "Connected to Network Drive: $drive"
else
    echo "Connected with the wrong Network: $SSID"
fi

done
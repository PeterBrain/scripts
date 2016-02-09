#!/bin/sh

SSID=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk -F': ' '/ SSID/ {print $2}')

drives="Public www$ Peter$"
drives_all="Public www$ Peter$ Bilder Movies Games"
drives_school="vPublic classes ITDaten"

mkdir /tmp/share

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
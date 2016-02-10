#!/bin/sh
#exec > /dev/null 2>&1
set +v

en0=`ipconfig getifaddr en0`
en1=`ipconfig getifaddr en1`

if [ -n "$en1" ]; then

echo "\033[0;32m"Connected with WLAN-Network"\033[0m"

SSID=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk -F': ' '/ SSID/ {print $2}')

drives="Public www$ Peter$"
drives_all="Public www$ Peter$ Bilder Movies Games"
drives_school="classes ITDaten"

mkdir /tmp/share

if [ $SSID = "Home" ]; then

for drive in $drives
do

	drive_mk=(${drive//$/})
	mkdir /tmp/share/${drive_mk[0]}
	mount -t smbfs smb://guest@SVR-01/$drive /tmp/share/${drive_mk[0]}

    echo "\033[0;32m"Connected to Network Drive: $drive"\033[0m"

done

elif [ $SSID == "3WebCube_A1ED" ]; then

for drive in $drives_school
do
	drive_mk=(${drive//$/})
	mkdir /tmp/share/${drive_mk[0]}
	mount -t smbfs smb://guest@SVR-01/$drive /tmp/share/${drive_mk[0]}
	
	echo "\033[0;32m"Connected to Network Drive: $drive"\033[0m"

done

else
    echo "\033[0;31m"Connected with wrong Network: $SSID"\033[0m"
fi

fi

if [ -n "$en0" ]; then

echo "\033[0;32m"Connected with LAN-Network"\033[0m"

drives_school="classes"
mkdir /tmp/share

host = "dv-srvr-fs"
user = "loecker5227"
password = read


for drive in $drives_school
do
	drive_mk=(${drive//$/})
	mkdir /tmp/share/${drive_mk[0]}
	mount -t smbfs smb://$user:$password@$host/$drive /tmp/share/${drive_mk[0]}
	
	echo "\033[0;32m"Connected to Network Drive: $drive"\033[0m"

done

else
    echo "\033[0;31m"No ethernet cable connected"\033[0m"
fi

read -p "Press any key to close this terminal"
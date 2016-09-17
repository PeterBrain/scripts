#!/bin/sh
#exec > /dev/null 2>&1
set +v

drives="Public www$ Peter$ bin"
drives_all="Public www$ Peter$ Bilder Movies Games"
drives_school="classes ITDaten"

mkdir /tmp/share

for drive in $drives_all
do

drive_mk=(${drive//$/})
mkdir /tmp/share/${drive_mk[0]}
mount -t smbfs smb://guest@10.0.0.10/$drive /tmp/share/${drive_mk[0]}

echo "\033[0;32m"Connected to Network Drive: $drive"\033[0m"

done

#rm -rf /tmp/share

#read -p "Press enter to close this terminal"
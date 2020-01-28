#!/bin/sh

clear
ls -l /Volumes/
#tree /tmp/share/

echo
read -p "Type in the drive you want to disconnect: " share

x=`lsof -Fp /Volumes/$share | grep 'p'`
kill -9 "${x##p}"

diskutil umount /Volumes/$share


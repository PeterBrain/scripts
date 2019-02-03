#!/bin/sh

clear
ls -l /Volumes/

echo
read -p "Type in the drive you want to disconnect: " share

x=`lsof -Fp /Volumes/$share | grep 'p'`
kill -9 "${x##p}"


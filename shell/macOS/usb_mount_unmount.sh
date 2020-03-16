#!/bin/bash

printf "\nunmount USB drives\n\n"

read -p "Type 0 to unmount a drive (any other to mount): " var
diskutil list
read -p "Enter the name of the drive you want to mount/unmount: " usb

if [ "$var" == "0" ]; then
  diskutil unmount $usb
else
  diskutil mount $usb
fi

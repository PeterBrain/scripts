#!/bin/sh

echo
echo "unmount USB drives"
echo "Type 0 to unmount a drive"

read var

diskutil list

echo
echo "Type in the name of the drive you want to mount/unmount"
read usb
echo

if [ "$var" == "0" ]; then

diskutil unmount "$usb"
#diskutil unmount /dev/disk4s1

else

diskutil mount "$usb"

fi

#df
#if [ "/Volumes/$usb" ]; then

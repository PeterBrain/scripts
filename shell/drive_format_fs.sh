#!/bin/sh

diskutil list

read -p "Select your disk: " disk
read -p "choose file system: " fs
read -p "choose name: " name

diskutil eraseDisk $fs $name $disk
#diskutil unmount /dev/disk4
#diskutil eject /dev/disk4

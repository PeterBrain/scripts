#!/usr/bin/env bash

diskutil list

read -rp "Select your disk: " disk
read -rp "choose file system: " fs
read -rp "choose name: " name

diskutil eraseDisk "${fs}" "${name}" "${disk}"
#diskutil unmount /dev/disk4
#diskutil eject /dev/disk4

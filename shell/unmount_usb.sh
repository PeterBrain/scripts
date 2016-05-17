#!/bin/sh

echo "unmount USB drives"
read

diskutil list
read
#diskutil unmount /dev/disk4s1 || diskutil mount /dev/disk4s1
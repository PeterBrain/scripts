#!/bin/sh

:`
drives="Public www$ Peter$ Bilder Games Movies"

for drive in $drives
do

drive_mk=(${drive//$/})
umount -t smbfs /tmp/share/${drive_mk[0]}
rmdir /tmp/share/${drive_mk[0]}

done
`

umount -A -t smbfs

rm -rf /tmp/share

#rmdir /tmp/share

#read -p "Press enter to close this terminal"
#!/bin/sh

drives="Public www$ Peter$ bin”

#for drive in $drives
#do

umount -A -t smbfs

#drive_mk=(${drive//$/})
#umount -t smbfs /tmp/share/${drive_mk[0]}
#rmdir /tmp/share/${drive_mk[0]}

#done

rmdir /tmp/share

read -p "Press any key to close this terminal"
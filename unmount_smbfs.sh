#!/bin/sh

drives="Public www$ Peter$"

for drive in $drives
do

drive_mk=(${drive//$/})
umount -t smbfs /tmp/share/${drive_mk[0]}
rmdir /tmp/share/${drive_mk[0]}

done

rmdir /tmp/share
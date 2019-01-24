#!/bin/sh

username="guest"
hostname="10.0.0.10"
mount_path=/tmp/share
shares=("Public" "www$" "Peter$")

drv_connect() {
  drives=$@
  for drive in ${drives[@]}
  do
    drive_mk=(${drive//$/})
    mkdir $mount_path/${drive_mk[0]}
    mount -t smbfs smb://$username@$hostname/$drive $mount_path/${drive_mk[0]}
  done
}

drv_connect ${shares[@]}

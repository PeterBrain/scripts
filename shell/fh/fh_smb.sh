#!/usr/bin/env bash

#exec > /dev/null 2>&1
set +v

mount_path="/tmp/share"
username="<USERNAME>" #loeckerp17
password="$(security find-generic-password -wa $username)"
#drives_temp=("home" "info" "software" "ima17")
drives=("ima17")

#read -p "Enter the password for $username: " -s password

directories=( \
  "${mount_path}/abacus" \
  "${mount_path}/mars" \
  "${mount_path}/pluto" \
  "${mount_path}/mars/ima17" \
)

mkdir -p "${directories[@]}"

#mount -t smbfs smb://$username:$password@mars/ima17$/$username ${mount_path}/mars/ima17
#mount -t smbfs smb://$username:$password@pluto/facelift ${mount_path}/pluto

for drive in "${drives[@]}"
do
  drive_mk=("${drive//$/}")
  mkdir "${mount_path}"/abacus/"${drive_mk[0]}"
  mount -t smbfs smb://"${username}":"${password}"@abacus/"$drive" "${mount_path}"/abacus/"${drive_mk[0]}"
done

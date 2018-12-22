#!/bin/sh

server=( \
  "username|password@server1.com" \
  "username|password@server2.com" \
  "username|password@server3.com" \
  "username|password@server4.com" \
  "username|password@server5.com" \
  "username|password@server6.com" \
  "username|password@server7.com" \
)
connection_type=( \
  "ssh" "sftp" "ftp" "rsh" "telnet" "rlogin" "quit" \
)

clear
printf "\nConnect to your predefined Server really fast.\n\n"
PS3="Pick a server (or ctrl-c to quit): "

select item in "${server[@]}"
do
  clear
  echo "You are connecting to $item"
  PS3="Choose connection type (or ctrl-c to quit): "

  select type in "${connection_type[@]}"
  do
    read -p "Enter additional $type arguments \(or just press enter for none\): " args
    case "$type" in
      ssh ) ssh $args $item ;;
      sftp ) sftp $args $item ;;
      ftp ) ftp $args $item ;;
      rsh ) rsh $args $item ;;
      telnet ) telnet $args $item ;;
      rlogin ) rlogin $args $item ;;
      quit ) break ;;
      "" ) please select one of the above or press ctrl-c ;;
    esac
    exit 0
  done
  exit 0
done

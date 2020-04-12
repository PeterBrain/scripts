#!/usr/bin/env bash

printf "\nMake a dummy file with one or several bytes (b), kilobytes (k), megabytes (m), gigabytes (g)\n"

read -rp "Type in a filesize (1 Gigabyte = 1g): " filesize
read -rp "Name the File: " name
read -rp "Give it an extension: " extension
read -rp "Choose a storage directory (leave blank for desktop): " path

if [ -n "$path" ]; then
  cd Desktop || exit
else
  cd "$path" || exit
fi

mkfile "$filesize" "$name"."$extension"
#mkfile 1g test.abc

open .

#!/bin/sh

printf "\nMake a dummy file with one or several bytes (b), kilobytes (k), megabytes (m), gigabytes (g)\n"

read -p "Type in a filesize (1 Gigabyte = 1g): " filesize
read -p "Name the File: " name
read -p "Give it an extension: " extension
read -p "Choose a storage directory (leave blank for desktop): " path

if [ -n $path ]; then
  cd Desktop
else
  cd $path
fi

mkfile $filesize $name.$extension
#mkfile 1g test.abc

open .

#!/usr/bin/env bash

i=1
sp="/-\|"
echo -n ' '
while true
do
  printf "\b${sp:i++%${#sp}:1}"
done

#!/bin/bash

clear
printf "\nOpen a predefined path\n\n"
PS3="Which one do you want to open? (or ctrl-c to quit): "

directories=( \
  "/var/" # variable data (log files)
  "/tmp/" # temporary files, cache
  "/etc/" # host-specific configuration (hosts)
  "/dev/" # device files
  "/usr/" # unix system resources, cli binaries, libraries
  "/Volumes/" # mounted devices
  "/Library/" # system library
  "/Applications/" # system applications
  "/Users/$USER/Library/" # user library
  #"/Users/$USER/Applications/" # user applications
  "/Users/$USER/Library/Mobile Documents/com~apple~CloudDocs" # iCloud
  "/Library/WebServer/Documents" # webserver
)

select directory in "${directories[@]}"
do
  cd "$directory"
  open .
  exit
done

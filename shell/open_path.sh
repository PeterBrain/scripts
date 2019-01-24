#!/bin/sh

clear
printf "\nOpen a predefined path\n\n"
PS3="Which one do you want to open? (or ctrl-c to quit): "

directories=( \
  "/desktop/" \
  "/private/etc/" \
  "/tmp/" \
  "/Users/$USER/.taco_home/" \
  "/Users/$USER/.npm" \
  "/Users/$USER/.homebridge" \
  "/Users/$USER/Library/Mobile Documents/com~apple~CloudDocs" \
  "/Library/WebServer/Documents" \
)

select directory in "${directories[@]}"
do
  cd "$directory"
  open .
  exit
done

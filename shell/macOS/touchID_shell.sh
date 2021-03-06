#!/usr/bin/env bash

## this script will enable TouchID for certain commands in terminal and actions (e.g. Finder)

auth_expr="auth sufficient pam_tid.so" # auth expression to enable touchID
path="/etc/pam.d/sudo" # path to file for auth expression

if ! grep -lr "${auth_expr}" "${path}"; then # false, if the auth expression is already there
  sudo cp "${path}" "${path}.bkp" # create backup file of the old configuration
  sudo sed -i '' -e "1s/^//p; 1s/^.*/${auth_expr}/" "${path}" # duplicated first row and replaces it with the auth expression
else
  echo "The script ran once already - nothing to do here"
fi

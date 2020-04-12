#!/usr/bin/env bash

printf "\nPlease specify a username:"
read -r username

htpasswd -cB htpasswd_ "$username"

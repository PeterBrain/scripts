#!/bin/bash

echo "\nPlease specify a username:"
read username

htpasswd -cB htpasswd_ $username

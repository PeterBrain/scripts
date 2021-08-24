#!/usr/bin/env bash

user="<USERNAME>" #loeckerp17
pass="$(security find-generic-password -wa ${user})"

echo "${pass}" | sudo openconnect -u "${user}" --passwd-on-stdin "https://vpn.fh-joanneum.at"

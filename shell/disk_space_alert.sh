#!/usr/bin/env bash

STATUS="$(df -h)"
CURRENT="$(df / | grep / | awk '{print $5}' | sed 's/%//g')"
THRESHOLD=90

if [ "$CURRENT" -gt "$THRESHOLD" ]; then
  mail -s "Disk Space Alert" -b "bcc@example.com" "to@example.com" << EOF
Your root partition remaining free space is critically low. Used: ${CURRENT}%

${STATUS}
EOF
fi

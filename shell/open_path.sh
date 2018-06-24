#!/bin/sh

echo
echo "Which number do you want to open?"
echo
echo "1. hosts file"
echo "2. taco home (remotebuild)"
echo "3. /tmp/ - mounted my shared folders in there"
echo "4. npm"
echo "5. homebridge"
echo "6. iCloud"
echo
read val

case $val in
    "1") cd /private/etc/;;
    "2") cd /Users/peterbrain/.taco_home/;;
    "3") cd /tmp/;;
    "4") cd /Users/peterbrain/.npm;;
    "5") cd /Users/peterbrain/.homebridge;;
    "6") cd /Users/peterbrain/Library/Mobile Documents/com~apple~CloudDocs;;
    *) cd /desktop/;;
esac

open .

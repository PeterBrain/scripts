#!/bin/sh

echo
echo "Which number do you want to open?"
echo
echo "1. hosts file"
echo "2. taco home (remotebuild)"
echo "3. /tmp/ - mounted my shared folders in there"
echo
read val

case $val in
    "1") cd /private/etc/;;
    "2") cd /Users/peterbrain/.taco_home/;;
    "3") cd /tmp/;;
    "4") cd /Users/peterbrain/.npm;;
    "5") cd /Users/peterbrain/.homebridge;;
    *) cd /desktop/;;
esac



#if [ $val == "1" ]; then

#cd /private/etc/

#elif [ $val == "2" ]; then

#cd /Users/PeterBrain/.taco_home
#/Users/PeterBrain/.taco_home/remote-builds/taco-remote/builds/

#fi



open .

#!/bin/sh

echo
echo "Which number do you want to open?"
echo
echo "1. Path to hosts file"
echo "2. taco home (remotebuild)"
echo
read val

case $val in
    "1") cd /private/etc/;;
    "2") cd /Users/PeterBrain/.taco_home/;;
    *) cd /desktop/;;
esac


#if [ $val == "1" ]; then

#cd /private/etc/

#elif [ $val == "2" ]; then

#cd /Users/PeterBrain/.taco_home
#/Users/PeterBrain/.taco_home/remote-builds/taco-remote/builds/

#fi

open .
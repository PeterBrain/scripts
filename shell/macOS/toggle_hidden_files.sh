#!/bin/bash

status=`defaults read com.apple.finder AppleShowAllFiles`

if [ $status == YES ]; then
    defaults write com.apple.finder AppleShowAllFiles NO
else
    defaults write com.apple.finder AppleShowAllFiles YES
fi

killall Finder

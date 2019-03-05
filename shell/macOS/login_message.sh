#!/bin/sh

check=`sudo defaults read /Library/Preferences/com.apple.loginwindow LoginwindowText`

if [ n $check ]; then
  echo "Type in the message you want to display:"
  read message
  sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "$message"
else
  sudo defaults delete /Library/Preferences/com.apple.loginwindow LoginwindowText
fi

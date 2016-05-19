#!/bin/sh

echo
echo "Add blank space to the dock"
echo

defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'

killall Dock
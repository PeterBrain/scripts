#!/bin/sh

echo "Add blank space to the dock"

defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'

killall Dock
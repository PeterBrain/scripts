#!/usr/bin/env bash

printf "\nWarning! This script will disable your keyboard (macOS)."
printf "\nTo turn your internal keyboard back on, simply run the script again.\n(You may have to use an external keyboard for this)\n\n"
read -rp "Press enter to proceed (or ctrl-c to quit) "

sudo kextunload -b com.apple.driver.AppleUSBTCKeyboard || kextload -b com.apple.driver.AppleUSBTCKeyboard
#sudo kextunload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext/ || sudo kextload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext/

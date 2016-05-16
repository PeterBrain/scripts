#!/bin/sh

echo "To turn your internal keyboard back on, simply run the script again"
echo "you may have to use an external keyboard for this"

echo "To proceed, press enter"
read

sudo kextunload -b com.apple.driver.AppleUSBTCKeyboard || kextload -b com.apple.driver.AppleUSBTCKeyboard

#sudo kextunload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext/ || sudo kextload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext/
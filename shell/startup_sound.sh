#!/bin/sh

echo
echo "Disable startup sound"
echo

sudo nvram SystemAudioVolume=%01
#80

#sudo nvram -d SystemAudioVolume
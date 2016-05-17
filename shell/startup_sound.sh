#!/bin/sh

echo "Disable startup sound"

sudo nvram SystemAudioVolume=%01
#80

#sudo nvram -d SystemAudioVolume
#!/bin/sh

function response() {
    read -r response
    if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    ${1}
    fi
}

res=(
"cd Desktop"
"mkdir test"
)

response "echo ${res[*]}"
read


check=`sudo defaults read /Library/Preferences/com.apple.iokit.AmbientLightSensor "Backlight 1"`
check_3=`sudo kextload /System/Library/Extensions/AppleBacklight.kext`

check_all=`sudo defaults read /Library/Preferences/com.apple.iokit.AmbientLightSensor`

echo $check_all
echo $check_3

#sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Keyboard Muted"

read
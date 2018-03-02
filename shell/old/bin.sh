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


# sudo rm -rf ~/Documents/Adobe
sudo rm -rf /Library/Application\ Support/Adobe*
sudo rm -rf /Library/Application\ Support/regid.*.com.adobe
sudo rm -rf /Library/Caches/com.{a,A}dobe*
sudo rm -rf /Library/Fonts/{a,A}dobe*
sudo rm -rf /Library/Preferences/com.{a,A}dobe*
sudo rm -rf /Library/ScriptingAdditions/Adobe\ Unit\ Types.osax
sudo rm -rf /Users/Shared/Adobe
sudo rm -rf ~/Library/Application\ Support/Adobe*
sudo rm -rf ~/Library/Caches/Adobe*
sudo rm -rf ~/Library/Caches/com.adobe*
sudo rm -rf ~/Library/Preferences/Adobe*
sudo rm -rf ~/Library/Preferences/ByHost/com.adobe*
sudo rm -rf ~/Library/Preferences/com.{a,A}dobe*
sudo rm -rf ~/Library/Preferences/Macromedia
sudo rm -rf ~/Library/Saved\ Application\ State/com.{a,A}dobe*


python -m SimpleHTTPServer 8000
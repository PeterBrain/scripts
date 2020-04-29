#!/usr/bin/env bash

decode64() { ## decode base64 encoded string
  echo "$1" | base64 --decode # or -d
}

read -r


check="$(sudo defaults read /Library/Preferences/com.apple.iokit.AmbientLightSensor "Backlight 1")"
check_3="$(sudo kextload /System/Library/Extensions/AppleBacklight.kext)"
check_all="$(sudo defaults read /Library/Preferences/com.apple.iokit.AmbientLightSensor)"

echo "$check_all"
echo "$check_3"

#sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Keyboard Muted"

read -r


# sudo rm -rf ~/Documents/Adobe
# sudo rm -rf /Library/Application\ Support/Adobe*
# sudo rm -rf /Library/Application\ Support/regid.*.com.adobe
# sudo rm -rf /Library/Caches/com.{a,A}dobe*
# sudo rm -rf /Library/Fonts/{a,A}dobe*
# sudo rm -rf /Library/Preferences/com.{a,A}dobe*
# sudo rm -rf /Library/ScriptingAdditions/Adobe\ Unit\ Types.osax
# sudo rm -rf /Users/Shared/Adobe
# sudo rm -rf ~/Library/Application\ Support/Adobe*
# sudo rm -rf ~/Library/Caches/Adobe*
# sudo rm -rf ~/Library/Caches/com.adobe*
# sudo rm -rf ~/Library/Preferences/Adobe*
# sudo rm -rf ~/Library/Preferences/ByHost/com.adobe*
# sudo rm -rf ~/Library/Preferences/com.{a,A}dobe*
# sudo rm -rf ~/Library/Preferences/Macromedia
# sudo rm -rf ~/Library/Saved\ Application\ State/com.{a,A}dobe*

read -r

python -m SimpleHTTPServer 8000

read -r

while (true); do
    tput bel
done

read -r

case $(uname) in
	Linux) echo "Hello Linux user" ;;
	Darwin) echo "Hello macOS user" ;;
    FreeBSD|OpenBSD) echo "Hello FreeBSD or OpenBSD user" ;;
	*) ;;
esac

read -r

NC='\033[0m' # no color
black='\033[0;30m'
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
magenta='\033[0;35m'
cyan='\033[0;36m'
white='\033[0;37m'

function cecho() {
    case $2 in
        "false") color=$red;;
        "true") color=$green;;
        *) color=$2;;
    esac

    echo "${color}${1}${NC}"
    return
}

function response() {
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY][eE]|[yY])$ ]]; then
        "${1}"
    fi
}

function test1() {
    cecho "Enabling Debug Menus 1" "$1"
}

function test2() {
    cecho "Enabling Debug Menus 2" "$1"
}

function test3() {
    cecho "Enabling Debug Menus 3" "$1"
}

test1 false
test2 true
test3

read -r

M2_EXCLUDE=(./web/pub/{media,static} ./web/var/{cache,di})
VERSION=m2
echo "${M2_EXCLUDE[*]}"
echo "$(if [ "${VERSION}" == "m2" ]; then ${M2_EXCLUDE[*]}; fi)"
echo "$(if [ "${VERSION}" == "m2" ]; then for exclude in "${M2_EXCLUDE[@]}"; do echo "--exclude=${exclude} \ "; done; fi)"
echo "$(if [ "${VERSION}" == "m2" ]; then echo "${M2_EXCLUDE[@]/#/--exclude=}"; fi)"

read -r

res=(
    "cd Desktop"
    "mkdir test"
)

response "echo ${res[*]}"

read -r

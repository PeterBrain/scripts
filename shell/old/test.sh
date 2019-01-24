#!/bin/sh

#while (true)
#do
#    tput bel
#done


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
    if [[ $response =~ ^([yY][eE][sS]|[yY][eE]|[yY])$ ]]; then
        ${1}
    fi
}

function test1() {
    cecho "Enabling Debug Menus 1" $1
}

function test2() {
    cecho "Enabling Debug Menus 2" $1
}

function test3() {
    cecho "Enabling Debug Menus 3" $1
}

test1 false
test2 true
test3

read

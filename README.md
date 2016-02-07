# Scripts
This is a collection of all my shell scripts

## run_evonHome

    #!/bin/sh
    cd /Users/PeterBrain/Desktop/evonHOME
    node System/plc.js

## ShowHiddenFiles

    #!/bin/sh
    defaults write com.apple.finder AppleShowAllFiles YES
    killall Finder

## HideHiddenFiles

    #!/bin/sh
    defaults write com.apple.finder AppleShowAllFiles NO
    killall Finder
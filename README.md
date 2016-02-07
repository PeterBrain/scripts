# Scripts
This is a collection of all my shell scripts

&nbsp;

## Introduction
### Executable
Define, how the file should be interpreted.

```
#!/bin/sh
#!/bin/bash
```
&nbsp;

## Programs

&nbsp;

Here are all the code,
### run_evonHome
This is for my current project, which acts as a degree dissertation

```
#!/bin/sh
cd /Users/PeterBrain/Desktop/evonHOME
node System/plc.js
```

&nbsp;

### ShowHiddenFiles
I’m too tired of typing this line into the command-line-tool, so I’ve done this.
Explanation: Make files, which are usually invisible to us, visible.

```
#!/bin/sh
defaults write com.apple.finder AppleShowAllFiles YES
killall Finder
```

&nbsp;

### HideHiddenFiles
To reverse the effect of "ShowHiddenFiles". Better: Make actual invisible files invisible.

```
#!/bin/sh
defaults write com.apple.finder AppleShowAllFiles NO
killall Finder
```

&nbsp;

### mount smb Network Drive
Aliases of Network Drives do the same thing, but need more space on desktop and it’s much cooler to do it that way.

```
#!/bin/sh
SSID=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk -F': ' '/ SSID/ {print $2}')

drives="Public www$ Peter$"
for drive in $drives
do

if [ "$SSID" = "Home" ]
then
drive_mk=(${drive//$/})
mkdir /tmp/share/${drive_mk[0]}
mount -t smbfs smb://guest@SVR-01/$drive /tmp/share/${drive_mk[0]}

echo "Connected to Network Drive: $drive"
else
echo "Connected with the wrong Network: $SSID"
fi

done
```
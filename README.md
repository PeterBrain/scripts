# Scripts
This is a collection of all my shell scripts


&nbsp;
## Introduction
### Executable
Define, how the file should be interpreted.


&nbsp;
```
#!/bin/sh
#!/bin/bash
```

## Programs
Here are all the code,
### run_evonHome

```
#!/bin/sh
cd /Users/PeterBrain/Desktop/evonHOME
node System/plc.js
```

### ShowHiddenFiles

```
#!/bin/sh
defaults write com.apple.finder AppleShowAllFiles YES
killall Finder
```

### HideHiddenFiles

```
#!/bin/sh
defaults write com.apple.finder AppleShowAllFiles NO
killall Finder
```

### mount smb Network Drive

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
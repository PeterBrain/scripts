[![GitHub followers](https://img.shields.io/github/followers/peterbrain.svg?style=social&label=Follow)](https://github.com/peterbrain)
[![GitHub watchers](https://img.shields.io/github/watchers/peterbrain/scripts.svg?style=social&label=Watch)](https://github.com/peterbrain/scripts)
[![GitHub stars](https://img.shields.io/github/stars/peterbrain/scripts.svg?style=social&label=Star)]()
[![GitHub forks](https://img.shields.io/github/forks/peterbrain/scripts.svg?style=social&label=Fork)]()

[![GitHub author](https://img.shields.io/badge/Author-PeterBrain-3BCDD6.svg)](http://peterbrain.github.io)
[![GitHub author](https://img.shields.io/badge/language-Batch | Shell | ...-000000.svg)]()

# Scripts
This is a collection of all my shell and batch scripts.

Everything that needs a long time and has to be done very often is now a script. In my case.

&nbsp;

## Introduction
### Executable
Define, how the file should be interpreted.

```
#!/bin/sh
#!/bin/bash
```
&nbsp;

To restart Finder, in order to activate new settings use the following:

```
killall Finder
```
&nbsp;

If- Else Statements are done like this.

```
if [condition]
then
(… do something here)
else
(… do something here)
fi
```
&nbsp;

Loops and those stuff.

```
for variable in defined_variable
do
(… do something here)
done
```
&nbsp;

Create and delete Folders. Just like God.

Create:
```
mkdir path/to/folder/name_of_folder
```

Delete:
```
rmdir path/to/folder/name_of_folder
```
&nbsp;

Stress test your MAC:
```
yes
```
To cancel press __Ctrl-C__

&nbsp;

This makes the file executable on doubleclick:
```
chmod a+x file.sh
```
&nbsp;

## Programs
Description of all Programs.
&nbsp;

### run_evonHome
This is for my current project, which acts as a degree dissertation.
```
cd /Users/PeterBrain/Desktop/evonHOME
node System/plc.js
```
&nbsp;

### ShowHiddenFiles
I’m too tired of typing this line into the command-line-tool, so I’ve done this.
Explanation: Make files, which are usually invisible to us, visible. Restart of Finder is necessary.
```
defaults write com.apple.finder AppleShowAllFiles YES
```
&nbsp;

### HideHiddenFiles
To reverse the effect of "ShowHiddenFiles". Better: Make actual invisible files invisible. Restart of Finder is necessary.
```
defaults write com.apple.finder AppleShowAllFiles NO
```
&nbsp;

### ToggleHiddenFiles
To toggle it is necessary to know the current setting.
```
status=`defaults read com.apple.finder AppleShowAllFiles`
```
&nbsp;

### mount/unmount smb Network Drive
Aliases of Network Drives do the same thing, but need more space on desktop and it’s much cooler to do it that way.

This part of the code retrieves the SSID of the connected wireless network.
```
SSID=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk -F': ' '/ SSID/ {print $2}')
```
&nbsp;

Exploding strings is often very important and useful (IFS for later research): `array=(${variable//delimiter/})`

How to use the created array: `${array[0]}`

&nbsp;

Mount a smb network drive:
```
mount -t smbfs smb://user@server/share /path/to/temporary/shared_folder
```

Unmount a smb network drive:
```
umount -t smbfs /path/to/temporary/shared_folder
```
I recommend using this path: `/tmp/share/name_of_share`

&nbsp;

### mount/unmount USB Drive
Diskutil is the one keyword.
```
diskutil list
diskutil mount [DiskIdentifier|DeviceNode]
diskutil unmount [DiskIdentifier|DeviceNode]
```
When using the USB Drives name, you have to quote it.
DeviceNode expample: /dev/disk1s1

&nbsp;

### Turn internal keyboard on/off
To turn the keyboard on or off you have to unload or load a .kext file.

This one disables it:
```
kextunload -b com.apple.driver.AppleUSBTCKeyboard
```

And this one enables it:
```
kextload -b com.apple.driver.AppleUSBTCKeyboard
```
!Attention! Maybe you have to use an external Keyboard to re-enable it.

Long Version with real Paths:
```
sudo kextunload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext/ || sudo kextload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext/
```
&nbsp;

### Create a blank icon on dock
This feature is good to separate applications from each other.

This is all the magic:
```
defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'

killall Dock
```
The blank space stays after a reboot, so you have to run it only once.
&nbsp;

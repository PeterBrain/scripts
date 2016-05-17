# Scripts
This is a collection of all my shell and batch scripts.

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
&nbsp;

I recommend using this path: `/tmp/share/name_of_share`
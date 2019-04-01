# Scripts
This is a collection of all my Shell, Batch, PowerShell and Visual Basic scripts.

Everything that needs a long time and has to be done very often is now a script.
At least in my case.
Most of them are intended to run on macOS and Windows.

## mount/unmount smb Network Drive
Get the SSID of the currently connected wireless network:
```
SSID=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk -F': ' '/ SSID/ {print $2}')
```

Mount a smb network drive:
```
mount -t smbfs smb://user@server/share /path/to/mount_point
```

Unmount a smb network drive:
```
umount -t smbfs /path/to/mount_point
```
I recommend using this mount point: `/Volumes/name_of_share`

Exploding strings is often very important and useful (IFS for later research): `array=(${variable//delimiter/})`
How to use the created array: `${array[0]}`

## Turn on/off internal keyboard
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

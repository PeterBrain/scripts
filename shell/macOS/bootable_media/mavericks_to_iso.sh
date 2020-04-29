#!/usr/bin/env bash

# Mount the Installer image
hdiutil attach /Applications/Install\ OS\ X\ Mavericks.app/Contents/SharedSupport/InstallESD.dmg -noverify -nobrowse -mountpoint /Volumes/install_app

# Create Mavericks sparseimage of 7316mb with a Single Partition - Apple Partition Map
hdiutil create -o /tmp/Mavericks -size 7316m -layout SPUD -fs HFS+J -type SPARSE

# Mount the Mavericks sparseimage
hdiutil attach /tmp/Mavericks.sparseimage -noverify -nobrowse -mountpoint /Volumes/install_build

# Restore the Base System into the Mavericks Blank sparseimage
asr restore -source /Volumes/install_app/BaseSystem.dmg -target /Volumes/install_build -noprompt -noverify -erase

# Remove Packages link and replace with actual files
rm /Volumes/OS\ X\ Base\ System/System/Installation/Packages
cp -rp /Volumes/install_app/Packages /Volumes/OS\ X\ Base\ System/System/Installation/

# Unmount the installer image
hdiutil detach /Volumes/install_app

# Unmount the Base System image
hdiutil detach /Volumes/OS\ X\ Base\ System/

# Optimise Sparseimage Size
hdiutil compact /tmp/Mavericks.sparseimage
hdiutil resize -size min /tmp/Mavericks.sparseimage

# Convert the Mavericks spareseimage to ISO/CD master
hdiutil convert /tmp/Mavericks.sparseimage -format UDTO -o /tmp/Mavericks.iso

# Rename the Mavericks ISO image and move it to the desktop
mv /tmp/Mavericks.iso.cdr ~/Desktop/'Mavericks 10.9.iso'

# Delete Mavericks.sparseimage file
rm -f /tmp/Mavericks.sparseimage

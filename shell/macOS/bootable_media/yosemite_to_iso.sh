#!/usr/bin/env bash

# Mount the Installer image
hdiutil attach /Applications/Install\ OS\ X\ Yosemite.app/Contents/SharedSupport/InstallESD.dmg -noverify -nobrowse -mountpoint /Volumes/install_app

# Create Yosemite sparseimage of 7316mb with a Single Partition - Apple Partition Map
hdiutil create -o /tmp/Yosemite -size 7316m -layout SPUD -fs HFS+J -type SPARSE

# Mount the Yosemite sparseimage
hdiutil attach /tmp/Yosemite.sparseimage -noverify -nobrowse -mountpoint /Volumes/install_build

# Restore the Base System into the Yosemite Blank sparseimage
asr restore -source /Volumes/install_app/BaseSystem.dmg -target /Volumes/install_build -noprompt -noverify -erase

# Remove Packages link and replace with actual files
rm /Volumes/OS\ X\ Base\ System/System/Installation/Packages
cp -rp /Volumes/install_app/Packages /Volumes/OS\ X\ Base\ System/System/Installation/

# Copy Yosemite installer dependencies
cp -rp /Volumes/install_app/BaseSystem.chunklist /Volumes/OS\ X\ Base\ System/BaseSystem.chunklist
cp -rp /Volumes/install_app/BaseSystem.dmg /Volumes/OS\ X\ Base\ System/BaseSystem.dmg

# Unmount the installer image
hdiutil detach /Volumes/install_app

# Unmount the Base System image
hdiutil detach /Volumes/OS\ X\ Base\ System/

# Optimise Sparseimage Size
hdiutil compact /tmp/Yosemite.sparseimage
hdiutil resize -size min /tmp/Yosemite.sparseimage

# Convert the Yosemite spareseimage to ISO/CD master
hdiutil convert /tmp/Yosemite.sparseimage -format UDTO -o /tmp/Yosemite.iso

# Rename the Yosemite ISO image and move it to the desktop
mv /tmp/Yosemite.iso.cdr ~/Desktop/'Yosemite 10.10.iso'

# Delete Yosemite.sparseimage file
rm -f /tmp/Yosemite.sparseimage

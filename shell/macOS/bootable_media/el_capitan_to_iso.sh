#!/usr/bin/env bash

# Mount the Installer image
hdiutil attach /Applications/Install\ OS\ X\ El\ Capitan.app/Contents/SharedSupport/InstallESD.dmg -noverify -nobrowse -mountpoint /Volumes/install_app

# Create El Capitan sparseimage of 7316mb with a Single Partition - Apple Partition Map
hdiutil create -o /tmp/ElCapitan -size 7316m -layout SPUD -fs HFS+J -type SPARSE

# Mount the El Capitan sparseimage
hdiutil attach /tmp/ElCapitan.sparseimage -noverify -nobrowse -mountpoint /Volumes/install_build

# Restore the Base System into the El Capitan Blank sparseimage
asr restore -source /Volumes/install_app/BaseSystem.dmg -target /Volumes/install_build -noprompt -noverify -erase

# Remove Packages link and replace with actual files
rm /Volumes/OS\ X\ Base\ System/System/Installation/Packages
cp -rp /Volumes/install_app/Packages /Volumes/OS\ X\ Base\ System/System/Installation/

# Copy El Capitan installer dependencies
cp -rp /Volumes/install_app/BaseSystem.chunklist /Volumes/OS\ X\ Base\ System/BaseSystem.chunklist
cp -rp /Volumes/install_app/BaseSystem.dmg /Volumes/OS\ X\ Base\ System/BaseSystem.dmg

# Unmount the installer image
hdiutil detach /Volumes/install_app

# Unmount the Base System image
hdiutil detach /Volumes/OS\ X\ Base\ System/

# Convert the ElCapitan spareseimage image to ISO/CD master
hdiutil convert /tmp/ElCapitan.sparseimage -format UDTO -o /tmp/ElCapitan.iso

# Rename the ElCapitan ISO image and move it to the desktop
mv /tmp/ElCapitan.iso.cdr ~/Desktop/'El Capitan 10.11.iso'

# Delete ElCapitan.sparseimage file
rm -f /tmp/ElCapitan.sparseimage

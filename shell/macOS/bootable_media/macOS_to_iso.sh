#!/usr/bin/env bash

echo
echo "Which OS do you like to convert to an iso file (M - Mavericks, Y - Yosemite, E - El Capitan, S - Sierra (currently not supportet)"
echo

read -r os

os_name=("Mavericks" "Yosemite" "El\ Capitan")
os_version=(10.9 10.10 10.11)

if [ -z "$os" ]; then
    exit
elif [ "$os" == "M" ]; then
    index=0
elif [ "$os" == "Y" ]; then
    index=1
elif [ "$os" == "E" ]; then
    index=2
elif [ "$os" == "S" ]; then
    index=3
else
    echo "There is no OS named $os"
fi


# Mount the Installer image
hdiutil attach /Applications/Install\ OS\ X\ "${os_name[index]}".app/Contents/SharedSupport/InstallESD.dmg -noverify -nobrowse -mountpoint /Volumes/install_app

if [ "$index" == 2 ]; then
    os_name[2]="ELCapitan"
fi

# Create OS X sparseimage of 7316mb with a Single Partition - Apple Partition Map
hdiutil create -o /tmp/"${os_name[index]}" -size 7316m -layout SPUD -fs HFS+J -type SPARSE

# Mount the OS X sparseimage
hdiutil attach /tmp/"${os_name[index]}".sparseimage -noverify -nobrowse -mountpoint /Volumes/install_build

# Restore the Base System into the OS X Blank sparseimage
asr restore -source /Volumes/install_app/BaseSystem.dmg -target /Volumes/install_build -noprompt -noverify -erase

# Remove Packages link and replace with actual files
rm /Volumes/OS\ X\ Base\ System/System/Installation/Packages
cp -rp /Volumes/install_app/Packages /Volumes/OS\ X\ Base\ System/System/Installation/

# Copy OS X installer dependencies
cp -rp /Volumes/install_app/BaseSystem.chunklist /Volumes/OS\ X\ Base\ System/BaseSystem.chunklist
cp -rp /Volumes/install_app/BaseSystem.dmg /Volumes/OS\ X\ Base\ System/BaseSystem.dmg

# Unmount the installer image
hdiutil detach /Volumes/install_app

# Unmount the Base System image
hdiutil detach /Volumes/OS\ X\ Base\ System/

# Optimise Sparseimage Size
hdiutil compact /tmp/"${os_name[index]}".sparseimage
hdiutil resize -size min /tmp/"${os_name[index]}".sparseimage

# Convert the OS X spareseimage image to ISO/CD master
hdiutil convert /tmp/"${os_name[index]}".sparseimage -format UDTO -o /tmp/"${os_name[index]}".iso

# Rename the OS X ISO image and move it to the desktop
mv /tmp/"${os_name[index]}".iso.cdr ~/Desktop/"${os_name[index]}_${os_version[index]}.iso"

# Delete OS X.sparseimage file
rm -f /tmp/"${os_name[index]}".sparseimage

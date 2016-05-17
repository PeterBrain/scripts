#!/bin/sh

echo "MacBook preferred settings"

#————

#enable dark mode hotkey CMD+ALT+CTRL+T
#sudo defaults write /Library/Preferences/.GlobalPreferences.plist _HIEnableThemeSwitchHotKey -bool true

#————

#disable crashreport popup
#defaults write com.apple.CrashReporter UseUNC 1

#revert
#defaults write com.apple.CrashReporter UseUNC 0

#————

#launchpad rows columns
#defaults write com.apple.dock springboard-columns -int X
#defaults write com.apple.dock springboard-rows -int X
#defaults write com.apple.dock ResetLaunchPad -bool TRUE
#killall Dock

#to revert 5rows 7columns
#defaults delete com.apple.dock springboard-rows
#defaults delete com.apple.dock springboard-columns
#defaults write com.apple.dock ResetLaunchPad -bool TRUE
#killall Dock

#————

#AppStore show debug menu
#defaults write com.apple.appstore ShowDebugMenu -bool true

#revert
#defaults delete com.apple.appstore ShowDebugMenu

#Debug menu
#defaults write com.apple.addressbook ABShowDebugMenu -bool true
#defaults write com.apple.iCal IncludeDebugMenu -bool true

#defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
#defaults write com.apple.DiskUtility advanced-image-options -bool true

#————


#sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName
#sudo defaults delete /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName




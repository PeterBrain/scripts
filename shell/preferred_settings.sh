#!/bin/sh
#exec > /dev/null 2>&1

#———— Script settings

NC='\033[0m' # no color
black='\033[0;30m'
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
magenta='\033[0;35m'
cyan='\033[0;36m'
white='\033[0;37m'

function cecho() {
    echo "${2}${1}${NC}"
    return
}

function response() {
    read -r response
    if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    ${1}
    fi
}

#———— Title

echo
cecho "— Mac(Book) preferred configuration —" $magenta
echo
cecho "#####################################" $white
cecho "#                                   #" $white
cecho "#   DO NOT RUN THIS SCRIPT UNREAD   #" $white
cecho "#     YOU'LL PROBABLY REGRET IT     #" $white
cecho "#                                   #" $white
cecho "#       MADE & © BY PETERBRAIN      #" $white
cecho "#                                   #" $white
cecho "#####################################" $white
echo
cecho "By pressing enter you agree to make changes to your computer" $red
read

#———— Functions

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

set +e

##########################
# General UI/UX          #
##########################

function system_name() {
    cecho "Would you like to set a computer name (System Preferences -> Sharing)?  (y/n)" $magenta
    function computername() {
        cecho "What would you like it to be?" $magenta
        read COMPUTER_NAME
        sudo scutil --set ComputerName $COMPUTER_NAME
        sudo scutil --set HostName $COMPUTER_NAME
        sudo scutil --set LocalHostName $COMPUTER_NAME
        sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $COMPUTER_NAME
    }
    response computername
    echo
}

function debug_menu() {
    cecho "Enabling Debug Menus" $green
    # AppStore
    defaults write com.apple.appstore ShowDebugMenu -bool true

    # revert
    #defaults delete com.apple.appstore ShowDebugMenu

    # AdressBook & iCal
    defaults write com.apple.addressbook ABShowDebugMenu -bool true
    defaults write com.apple.iCal IncludeDebugMenu -bool true

    # Diskutility
    defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
    defaults write com.apple.DiskUtility advanced-image-options -bool true
}

function expand_save() {
    cecho "Expanding the save panel by default" $green
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
}

function save_not_icloud() {
    echo
    cecho "Save to disk, rather than iCloud, by default? (y/n)" $magenta
    response "defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false"
    echo
}

function printer_quit() {
    cecho "Automatically quit printer app once the print jobs complete" $green
    defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
}

function login_window_info() {
    cecho "Reveal IP address, hostname, OS version when clicking the clock in the login window" $green
    sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName
    #sudo defaults delete /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName
}

function auto_photos_device() {
    cecho "Disable Photos.app from starting everytime a device is plugged in" $green
    defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
}

function dark_mode_hotkey() {
    cecho "Enable dark mode hotkey CMD+ALT+CTRL+T" $green
    sudo defaults write /Library/Preferences/.GlobalPreferences.plist _HIEnableThemeSwitchHotKey -bool true
}

function crashreport_popup() {
    cecho "Disable crash-report popup and use notification instead" $green
    defaults write com.apple.CrashReporter UseUNC 1
    #defaults write com.apple.CrashReporter UseUNC 0
}

function hide_spotlight_icon() {
    cecho "Hide the Spotlight icon" $yellow
    #sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
}

function spotlight_indexing() {
    cecho "Disable Spotlight indexing for any volume that gets mounted and has not yet been indexed before" $yellow
    #echo 'Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.'
    #sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"
}

function check_update_daily() {
    cecho "Check for software updates daily, not just once per week" $yellow
    #defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
}

function remove_duplicates_open() {
    cecho "Removing duplicates in the 'Open With' menu" $yellow
    #/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user
}

function smart_quotes() {
    cecho "Disable smart quotes and samrt dashes" $yellow
    #defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
    #defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
}

function launchpad_row_column() {
    cecho "Edit amount of Launchpad rows and columns" $yellow
    cecho "(default 5rows 7columns)" $black
    #defaults write com.apple.dock springboard-columns -int X
    #defaults write com.apple.dock springboard-rows -int X
    #defaults write com.apple.dock ResetLaunchPad -bool TRUE
    #killall Dock

    # to revert 5rows 7columns
    #defaults delete com.apple.dock springboard-rows
    #defaults delete com.apple.dock springboard-columns
    #defaults write com.apple.dock ResetLaunchPad -bool TRUE
    #killall Dock
    echo
}

##########################
# Peripherie             #
##########################

function increase_sound_qual() {
    cecho "Increasing sound quality for Bluetooth headphones/headsets" $green
    defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40
}

function keyboard_ui_mode() {
    cecho "Enabling full keyboard access for all controls" $yellow
    cecho "(enable Tab in modal dialogs, menu windows, etc.)" $black
    #defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
    echo
}

function press_and_hold() {
    cecho "Disabling press-and-hold for special keys in favor of key repeat" $yellow
    #defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
}

function key_repeat() {
    cecho "Setting a blazingly fast keyboard repeat rate" $yellow
    #defaults write NSGlobalDomain KeyRepeat -int 0
}

function auto_correct() {
    cecho "Disable auto-correct" $yellow
    #defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
}

function mouse_track_speed() {
    cecho "Setting trackpad & mouse speed to a reasonable number" $yellow
    #defaults write -g com.apple.trackpad.scaling 2
    #defaults write -g com.apple.mouse.scaling 2.5
}

function keyboard_illumination() {
    cecho "Turn off keyboard illumination when computer is not used for 5 minutes" $green
    defaults write com.apple.BezelServices kDimTime -int 300 #5*60sec
}

function auto_display_brightness() {
    cecho "Disable display from automatically adjusting brightness" $yellow
    #sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Automatic Display Enabled" -bool false
}

function auto_keyboard_brightness() {
    cecho "Disable keyboard from automatically adjusting backlight brightness in low light" $yellow
    #sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Automatic Keyboard Enabled" -bool false
}

##########################
# Dock & Mission Control #
##########################

function wipe_dock() {
    cecho "Wipe all (default) app icons from the Dock" $yellow
    cecho "(This is only really useful when setting up a new Mac, or if you don't use the Dock to launch apps.)" $black
    #defaults write com.apple.dock persistent-apps -array
    echo
}

function icon_size_dock() {
    cecho "Setting the icon size of Dock items to 36 pixels for optimal size/screen-realestate" $green
    defaults write com.apple.dock tilesize -int 36
}

function hide_menu_bar() {
    cecho "Hide the menu bar" $yellow
    #defaults write "Apple Global Domain" "_HIHideMenuBar" 1
}

function autohide_menu_bar() {
    cecho "Set Dock to auto-hide and remove the auto-hiding delay" $yellow
    #defaults write com.apple.dock autohide -bool true
    #defaults write com.apple.dock autohide-delay -float 0
    #defaults write com.apple.dock autohide-time-modifier -float 0
}

function focus_ring_anim() {
    cecho "Disable the over-the-top focus ring animation" $yellow
    #defaults write NSGlobalDomain NSUseAnimatedFocusRing -bool false
}

function mission_control_anim() {
    cecho "Speeding up Mission Control animations and grouping windows by application" $yellow
    #defaults write com.apple.dock expose-animation-duration -float 0.1
    #defaults write com.apple.dock "expose-group-by-app" -bool true
}

##########################
# Mail                   #
##########################

function name_pasteboard() {
    cecho "Setting email addresses to copy as 'foo@example.com' instead of 'Foo Bar <foo@example.com>' in Mail.app" $yellow
    #defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false
}

##########################
# Terminal               #
##########################

function encode_theme() {
    cecho "Enabling UTF-8 ONLY in Terminal.app and setting the Pro theme by default" $yellow
    #defaults write com.apple.terminal StringEncodings -array 4
    #defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
    #defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"
}

##########################
# Time Machine           #
##########################

function no_offer_drive() {
    cecho "Prevent Time Machine from prompting to use new hard drives as backup volume" $yellow
    #defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
    echo
}

function local_backup() {
    cecho "Disable local Time Machine backups" $yellow
    cecho "(This can take up a ton of SSD space on <128GB SSDs)" $black
    #hash tmutil &> /dev/null && sudo tmutil disablelocal
    echo
}

##########################
# Messages               #
##########################

function emoji_substitution() {
    cecho "Disable automatic emoji substitution in Messages.app" $yellow
    cecho "(i.e. use plain text smileys)" $black
    #defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false
    echo
}

function smart_quotes_messages() {
    cecho "Disable smart quotes in Messages.app" $yellow
    cecho "(it's annoying for messages that contain code)" $black
    #defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false
    echo
}

function continous_spell_check() {
    cecho "Disable continuous spell checking in Messages.app" $yellow
    #defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false
}

##########################
# Additional Programs    #
##########################

function homebrew() {
    if test ! $(which brew); then
        cecho "Installing Homebrew? (y/n)" $magenta
        response "/usr/bin/ruby -e \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        cecho "Updating Homebrew" $green
        brew update
        brew upgrade
    fi

    brew doctor
    brew tap homebrew/dupes

    fails=()
    echo
}

function xcode() {
    cecho "Installing Xcode command line tools" $green
    xcode-select --install
    echo
}

#———— Execute

echo
echo "##########################"
echo "# General UI/UX          #"
echo "##########################"
echo

system_name
debug_menu
expand_save
save_not_icloud
printer_quit
login_window_info
auto_photos_device
dark_mode_hotkey
crashreport_popup
hide_spotlight_icon
spotlight_indexing
check_update_daily
remove_duplicates_open
smart_quotes
launchpad_row_column

echo
echo "##########################"
echo "# Peripherie             #"
echo "##########################"
echo

increase_sound_qual
keyboard_ui_mode
press_and_hold
key_repeat
auto_correct
mouse_track_speed
keyboard_illumination
auto_display_brightness
auto_keyboard_brightness

echo
echo "##########################"
echo "# Dock & Mission Control #"
echo "##########################"
echo

wipe_dock
icon_size_dock
hide_menu_bar
autohide_menu_bar
focus_ring_anim
mission_control_anim

echo
echo "##########################"
echo "# Mail                   #"
echo "##########################"
echo

name_pasteboard

echo
echo "##########################"
echo "# Terminal               #"
echo "##########################"
echo

encode_theme

echo
echo "##########################"
echo "# Time Machine           #"
echo "##########################"
echo

no_offer_drive
local_backup

echo
echo "##########################"
echo "# Messages               #"
echo "##########################"
echo

emoji_substitution
smart_quotes_messages
continous_spell_check

echo
echo "##########################"
echo "# Additional Programs    #"
echo "##########################"
echo

homebrew
xcode

read

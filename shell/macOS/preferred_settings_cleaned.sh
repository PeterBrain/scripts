#!/bin/bash

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

    case $2 in
        "false") color=$red;;
        "true") color=$green;;
        "quest") color=$magenta;;
        *) color=$2;;
    esac

    #echo -e "${2}${1}${NC}"
    echo -e "${color}${1}${NC}"

    return
}

function response() {
    read -r response
    if [[ $response =~ ^([yY][eE][sS]|[yY][eE]|[yY])$ ]]; then
        ${1} true
    elif [[ $response =~ ^([nN][oO]|[nN])$ ]]; then
        ${1} false
    fi
}

#———— Title

echo
cecho "— macOS preferred configuration —" $magenta
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
    cecho "Would you like to set a computer name (System Preferences -> Sharing)?  (y/n)" $1
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
    cecho "Enabling Debug Menus" $1
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
    cecho "Expanding the save panel by default" $1
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
}

function save_not_icloud() {
    echo
    cecho "Save to disk, rather than iCloud, by default? (y/n)" $1
    response "defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false"
    echo
}

function printer_quit() {
    cecho "Automatically quit printer app once the print jobs complete" $1
    defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
}

function login_window_info() {
    cecho "Reveal IP address, hostname, OS version when clicking the clock in the login window" $1
    sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName
    #sudo defaults delete /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName
}

function auto_photos_device() {
    cecho "Disable Photos.app from starting everytime a device is plugged in" $1
    defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
}

function dark_mode_hotkey() {
    cecho "Enable dark mode hotkey CMD+ALT+CTRL+T" $1
    sudo defaults write /Library/Preferences/.GlobalPreferences.plist _HIEnableThemeSwitchHotKey -bool true
}

function crashreport_popup() {
    cecho "Disable crash-report popup and use notification instead" $1
    if [ $1 == true ]; then
        defaults write com.apple.CrashReporter UseUNC 1
    else
        defaults write com.apple.CrashReporter UseUNC 0
    fi
}

function hide_spotlight_icon() {
    cecho "Hide the Spotlight icon" $1
    if [ $1 == true ]; then
        sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
    else
        sudo chmod 755 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
    fi
}

function spotlight_indexing() {
    cecho "Disable Spotlight indexing for any volume that gets mounted and has not yet been indexed before" $1
    echo 'Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.'
    sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"
}

function check_update_daily() {
    cecho "Check for software updates daily, not just once per week" $1
    defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
}

function remove_duplicates_open() {
    cecho "Removing duplicates in the 'Open With' menu" $1
    /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user
}

function smart_quotes() {
    cecho "Disable smart quotes and samrt dashes" $1
    defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
    defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
}

function launchpad_row_column() {
    cecho "Edit amount of Launchpad rows and columns" $1
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

function hide_menu_extra() {
    cecho "Hide the Time Machine, Volume, User, and Bluetooth icons" $1
    # Get the system Hardware UUID and use it for the next menubar stuff
    for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
        #defaults write "${domain}" dontAutoLoad -array \
        "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
        "/System/Library/CoreServices/Menu Extras/Volume.menu" \
        "/System/Library/CoreServices/Menu Extras/User.menu"
    done

    #defaults write com.apple.systemuiserver menuExtras -array \
    "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
    "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
    "/System/Library/CoreServices/Menu Extras/Battery.menu" \
    "/System/Library/CoreServices/Menu Extras/Clock.menu"
}

function indexing() {
    cecho "Change indexing order and disable some search results in Spotlight" $1

    # Yosemite-specific search results (remove them if your are using OS X 10.9 or older):
    #   MENU_DEFINITION
    #   MENU_CONVERSION
    #   MENU_EXPRESSION
    #   MENU_SPOTLIGHT_SUGGESTIONS (send search queries to Apple)
    #   MENU_WEBSEARCH             (send search queries to Apple)
    #   MENU_OTHER

    defaults write com.apple.spotlight orderedItems -array \
        '{"enabled" = 1;"name" = "APPLICATIONS";}' \
        '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
        '{"enabled" = 1;"name" = "DIRECTORIES";}' \
        '{"enabled" = 1;"name" = "PDF";}' \
        '{"enabled" = 1;"name" = "FONTS";}' \
        '{"enabled" = 0;"name" = "DOCUMENTS";}' \
        '{"enabled" = 0;"name" = "MESSAGES";}' \
        '{"enabled" = 0;"name" = "CONTACT";}' \
        '{"enabled" = 0;"name" = "EVENT_TODO";}' \
        '{"enabled" = 0;"name" = "IMAGES";}' \
        '{"enabled" = 0;"name" = "BOOKMARKS";}' \
        '{"enabled" = 0;"name" = "MUSIC";}' \
        '{"enabled" = 0;"name" = "MOVIES";}' \
        '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
        '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
        '{"enabled" = 0;"name" = "SOURCE";}' \
        '{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
        '{"enabled" = 0;"name" = "MENU_OTHER";}' \
        '{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
        '{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
        '{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
        '{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'

    # Load new settings before rebuilding the index
    #killall mds > /dev/null 2>&1

    # Make sure indexing is enabled for the main volume
    #sudo mdutil -i on / > /dev/null

    # Rebuild the index from scratch
    #sudo mdutil -E / > /dev/null
}

##########################
# General Power          #
##########################

function hibernation() {
    cecho "Disable hibernation? (speeds up entering sleep mode) (y/n)" $1

    function disable_hibernation() {
        if [ $1 == true ]; then
            sudo pmset -a hibernatemode 0
            cecho "Disabled" $red
        else
            sudo pmset -a hibernatemode 3
            cecho "Enabled" $green
        fi
    }

    response disable_hibernation
}

function rm_sleepFile() {
    cecho "Remove the sleep image file to save disk space? (y/n)" $1
    cecho "(If you're on a <128GB SSD, this helps but can have adverse affects on performance. You've been warned.)" $black

    function sleepFile() {
        sudo rm /Private/var/vm/sleepimage
        cecho "Creating a zero-byte file instead" $yellow
        sudo touch /Private/var/vm/sleepimage
        cecho "and make sure it can't be rewritten" $yellow
        sudo chflags uchg /Private/var/vm/sleepimage
    }

    response sleepFile
}

function sms() {
    cecho "Disable the sudden motion sensor (it's not useful for SSDs/current MacBooks)? (y/n)" $1

    function disable_sms() {
        if [ $1 == true ]; then
            sudo pmset -a sms 0
            cecho "Disabled" $red
        else
            sudo pmset -a sms 1
            cecho "Enabled" $green
        fi
    }

    response disable_sms
}

function system_resume() {
    cecho "Disable system-wide resume" $1
    defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false
}

function menu_tansparency() {
    cecho "Disable the menubar transparency" $1
    defaults write com.apple.universalaccess reduceTransparency -bool true
}

function speed_wakeup() {
    cecho "Speeding up wake from sleep to 24 hours from an hour" $1
    sudo pmset -a standbydelay 86400
}

##########################
# Screen                 #
##########################

function askForPassword() {
    cecho "Requiring password immediately after sleep or screen saver begins" $yellow
    defaults write com.apple.screensaver askForPassword -int 1
    defaults write com.apple.screensaver askForPasswordDelay -int 0
}

function screenshot_location() {
    cecho "Where do you want screenshots to be stored? (hit ENTER if you want ~/Desktop as default)" $magenta

    read screenshot_location

    if [ -z "${screenshot_location}" ]; then
        # If nothing specified, we default to ~/Desktop
        screenshot_location="${HOME}/Desktop"
    elif [[ "${screenshot_location:0:1}" != "/" ]]; then
        # If input doesn't start with /, assume it's relative to home
        screenshot_location="${HOME}/${screenshot_location}"
    fi

    cecho "Setting location to ${screenshot_location}" $yellow
    defaults write com.apple.screencapture location -string "${screenshot_location}"
}

function screenshot_format() {
    cecho "What format should screenshots be saved as? (hit ENTER for PNG, options: BMP, GIF, JPG, PDF, TIFF)" $magenta
    read screenshot_format
    if [ -z "$1" ]; then
        cecho "Setting screenshot format to PNG" $yellow
        defaults write com.apple.screencapture type -string "png"
    else
        cecho "Setting screenshot format to $screenshot_format" $yellow
        defaults write com.apple.screencapture type -string "$screenshot_format"
    fi
}

function subpix_render() {
    cecho "Enabling subpixel font rendering on non-Apple LCDs" $yellow
    defaults write NSGlobalDomain AppleFontSmoothing -int 2
}

function HiDPI() {
    cecho "Enabling HiDPI display modes (requires restart)" $yellow
    sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true
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
    defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
    echo
}

function press_and_hold() {
    cecho "Disabling press-and-hold for special keys in favor of key repeat" $yellow
    defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
}

function key_repeat() {
    cecho "Setting a blazingly fast keyboard repeat rate" $yellow
    defaults write NSGlobalDomain KeyRepeat -int 0
}

function auto_correct() {
    cecho "Disable auto-correct" $yellow
    defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
}

function mouse_track_speed() {
    cecho "Setting trackpad & mouse speed to a reasonable number" $yellow
    defaults write -g com.apple.trackpad.scaling 2
    defaults write -g com.apple.mouse.scaling 2.5
}

function keyboard_illumination() {
    cecho "Turn off keyboard illumination when computer is not used for 5 minutes" $green
    defaults write com.apple.BezelServices kDimTime -int 300 #5*60sec
}

function auto_display_brightness() {
    cecho "Disable display from automatically adjusting brightness" $yellow
    sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Automatic Display Enabled" -bool false
}

function auto_keyboard_brightness() {
    cecho "Disable keyboard from automatically adjusting backlight brightness in low light" $yellow
    sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Automatic Keyboard Enabled" -bool false
}

##########################
# Dock & Mission Control #
##########################

function wipe_dock() {
    cecho "Wipe all (default) app icons from the Dock" $yellow
    cecho "(This is only really useful when setting up a new Mac, or if you don't use the Dock to launch apps.)" $black
    defaults write com.apple.dock persistent-apps -array
    echo
}

function icon_size_dock() {
    cecho "Setting the icon size of Dock items to 36 pixels for optimal size/screen-realestate" $green
    defaults write com.apple.dock tilesize -int 36
}

function hide_menu_bar() {
    cecho "Hide the menu bar" $yellow
    defaults write "Apple Global Domain" "_HIHideMenuBar" 1
}

function autohide_menu_bar() {
    cecho "Set Dock to auto-hide and remove the auto-hiding delay" $yellow
    defaults write com.apple.dock autohide -bool true
    defaults write com.apple.dock autohide-delay -float 0
    defaults write com.apple.dock autohide-time-modifier -float 0
}

function focus_ring_anim() {
    cecho "Disable the over-the-top focus ring animation" $yellow
    defaults write NSGlobalDomain NSUseAnimatedFocusRing -bool false
}

function mission_control_anim() {
    cecho "Speeding up Mission Control animations and grouping windows by application" $yellow
    defaults write com.apple.dock expose-animation-duration -float 0.1
    defaults write com.apple.dock "expose-group-by-app" -bool true
}

##########################
# Finder                 #
##########################

function drives_on_desktop() {
    cecho "Show icons for hard drives, servers, and removable media on the desktop" $green
    defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
}

function HiddenFiles() {
    cecho "Show hidden files in Finder by default" $yellow
    defaults write com.apple.Finder AppleShowAllFiles -bool true
}

function dotfiles() {
    cecho "Show dotfiles in Finder by default" $yellow
    defaults write com.apple.finder AppleShowAllFiles TRUE
}

function suffix() {
    cecho "Show all filename extensions in Finder by default" $green
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true
}

function finder_status_bar() {
    cecho "Show status bar in Finder by default" $green
    defaults write com.apple.finder ShowStatusBar -bool true
}

function finder_path() {
    cecho "Display full POSIX path as Finder window title" $green
    defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
}

function suffix_change_warn() {
    cecho "Disable the warning when changing a file extension" $yellow
    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
}

function finder_column_view() {
    cecho "Use column view in all Finder windows by default" $yellow
    defaults write com.apple.finder FXPreferredViewStyle Clmv
}

function avoid_DS_Store() {
    cecho "Avoid creation and reading of .DS_Store files on network volumes" $yellow
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
}

function disk_img_verif() {
    cecho "Disable disk image verification" $yellow
    defaults write com.apple.frameworks.diskimages skip-verify -bool true
    defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
    defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true
}

function finder_prev_select() {
    cecho "Allowing text selection in Quick Look/Preview in Finder by default" $yellow
    defaults write com.apple.finder QLEnableTextSelection -bool true
}

function item_info() {
    cecho "Show item info near icons on the desktop and in other icon views" $yellow
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
}

function item_info_right() {
    cecho "Show item info to the right of the icons on the desktop" $yellow
    /usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom false" ~/Library/Preferences/com.apple.finder.plist
}

function snap_to_grid() {
    cecho "Enable snap-to-grid for icons on the desktop and in other icon views" $green
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
}

function grid_spacing() {
    cecho "Increase grid spacing for icons on the desktop and in other icon views" $yellow
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
}

function icon_size() {
    cecho "Increase the size of icons on the desktop and in other icon views" $yellow
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
}

##########################
# Mail                   #
##########################

function name_pasteboard() {
    cecho "Setting email addresses to copy as 'foo@example.com' instead of 'Foo Bar <foo@example.com>' in Mail.app" $yellow
    defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false
}

##########################
# Terminal               #
##########################

function encode_theme() {
    cecho "Enabling UTF-8 ONLY in Terminal.app and setting the Pro theme by default" $yellow
    defaults write com.apple.terminal StringEncodings -array 4
    defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
    defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"
}

##########################
# Time Machine           #
##########################

function no_offer_drive() {
    cecho "Prevent Time Machine from prompting to use new hard drives as backup volume" $yellow
    defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
    echo
}

function local_backup() {
    cecho "Disable local Time Machine backups" $yellow
    cecho "(This can take up a ton of SSD space on <128GB SSDs)" $black
    hash tmutil &> /dev/null && sudo tmutil disablelocal
    echo
}

##########################
# Messages               #
##########################

function emoji_substitution() {
    cecho "Disable automatic emoji substitution in Messages.app" $yellow
    cecho "(i.e. use plain text smileys)" $black
    defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false
    echo
}

function smart_quotes_messages() {
    cecho "Disable smart quotes in Messages.app" $yellow
    cecho "(it's annoying for messages that contain code)" $black
    defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false
    echo
}

function continous_spell_check() {
    cecho "Disable continuous spell checking in Messages.app" $yellow
    defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false
}

##########################
# Safari & WebKit        #
##########################

function safari_search_query() {
    cecho "Privacy: Don't send search queries to Apple" $green
    defaults write com.apple.Safari UniversalSearchEnabled -bool false
    defaults write com.apple.Safari SuppressSearchSuggestions -bool true
}

function safari_hide_bookmarks() {
    cecho "Hiding Safari's bookmarks bar by default" $yellow
    defaults write com.apple.Safari ShowFavoritesBar -bool false
}

function safari_sidebar() {
    cecho "Hiding Safari's sidebar in Top Sites" $yellow
    defaults write com.apple.Safari ShowSidebarInTopSites -bool false
}

function safari_thumbnail() {
    cecho "Disabling Safari's thumbnail cache for History and Top Sites" $yellow
    defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2
}

function safari_debug_mode() {
    cecho "Enabling Safari's debug menu" $green
    defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
}

function safari_constraint_search() {
    cecho "Making Safari's search banners default to Contains instead of Starts With" $yellow
    defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false
}

function rm_icons_bookmark_bar() {
    cecho "Removing useless icons from Safari's bookmarks bar" $yellow
    defaults write com.apple.Safari ProxiesInBookmarksBar "()"
}

function safari_develop_mode() {
    cecho "Enabling the Develop menu and the Web Inspector in Safari" $green
    defaults write com.apple.Safari IncludeDevelopMenu -bool true
    defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
    defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
}

function webInspector_contextMenu() {
    cecho "Adding a context menu item for showing the Web Inspector in web views" $yellow
    defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
}

function chrome_backswipe() {
    cecho "Disabling the annoying backswipe in Chrome" $yellow
    defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
    defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false
}

function chrome_print_preview() {
    cecho "Using the system-native print preview dialog in Chrome" $yellow
    defaults write com.google.Chrome DisablePrintPreview -bool true
    defaults write com.google.Chrome.canary DisablePrintPreview -bool true
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

#system_name quest
debug_menu true
expand_save true
#save_not_icloud false
printer_quit true
#login_window_info false
auto_photos_device true
dark_mode_hotkey true
crashreport_popup false
hide_spotlight_icon false
#spotlight_indexing false
#check_update_daily false
#remove_duplicates_open false
#smart_quotes false
#launchpad_row_column false
#hide_menu_extra false
#indexing false

echo
echo "##########################"
echo "# General Power          #"
echo "##########################"
echo

#hibernation quest
#rm_sleepFile quest
#sms quest
#system_resume false
#menu_tansparency false
#speed_wakeup false

echo
echo "##########################"
echo "# Screen                 #"
echo "##########################"
echo

#askForPassword false
#screenshot_location false
#screenshot_format false
#subpix_render false
#HiDPI false

echo
echo "##########################"
echo "# Peripherie             #"
echo "##########################"
echo

increase_sound_qual true
#keyboard_ui_mode false
#press_and_hold false
#key_repeat false
#auto_correct false
#mouse_track_speed false
keyboard_illumination true
#auto_display_brightness false
#auto_keyboard_brightness false

echo
echo "##########################"
echo "# Dock & Mission Control #"
echo "##########################"
echo

#wipe_dock false
#icon_size_dock true
#hide_menu_bar false
#autohide_menu_bar false
#focus_ring_anim false
#mission_control_anim false

echo
echo "##########################"
echo "# Finder                 #"
echo "##########################"
echo

drives_on_desktop true
#HiddenFiles false
#dotfiles false
suffix true
finder_status_bar true
finder_path true
#suffix_change_warn false
#finder_column_view false
#avoid_DS_Store false
#disk_img_verif false
#finder_prev_select false
#item_info false
#item_info_right false
snap_to_grid true
#grid_spacing false
#icon_size false

echo
echo "##########################"
echo "# Mail                   #"
echo "##########################"
echo

#name_pasteboard false

echo
echo "##########################"
echo "# Terminal               #"
echo "##########################"
echo

#encode_theme false

echo
echo "##########################"
echo "# Time Machine           #"
echo "##########################"
echo

#no_offer_drive false
#local_backup false

echo
echo "##########################"
echo "# Messages               #"
echo "##########################"
echo

#emoji_substitution false
#smart_quotes_messages false
#continous_spell_check false

echo
echo "##########################"
echo "# Safari & WebKit        #"
echo "##########################"
echo

safari_search_query true
#safari_hide_bookmarks false
#safari_sidebar false
#safari_thumbnail false
safari_debug_mode true
#safari_constraint_search false
#rm_icons_bookmark_bar false
safari_develop_mode true
#webInspector_contextMenu false
#chrome_backswipe false
#chrome_print_preview false

echo
echo "##########################"
echo "# Additional Programs    #"
echo "##########################"
echo

homebrew
xcode

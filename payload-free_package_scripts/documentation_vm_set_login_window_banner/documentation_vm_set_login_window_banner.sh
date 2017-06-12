#!/bin/bash

serial_number=`/usr/sbin/ioreg -l | awk '/IOPlatformSerialNumber/ {print $4}' | sed 's/\"//g'`
loginbanner=`printf "Initial Password: $serial_number\nYou will be prompted to change to a new password."`

# Set login window banner

/usr/bin/defaults write "$3"/Library/Preferences/com.apple.loginwindow LoginwindowText "$loginbanner"

exit 0
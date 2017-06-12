#!/bin/bash

# Account shortname
shortname=admin

# Account's full name
fullname="Administrator"

# Checks to see what is the highest UID in use
maxUID=$(/usr/bin/dscl . list /Users UniqueID | awk '{print $2}' | sort -ug | tail -1)

# Displays the serial number of the machine
serial_number=`/usr/sbin/ioreg -l | awk '/IOPlatformSerialNumber/ {print $4}' | sed 's/\"//g'`

# If the highest UID in use is greater than 500, the account will use a UID 
# that is one digit higher than the largest UID in use. Otherwise, the account
# will use the number 501 for its UID.

if [[ "$maxUID" -ge 500 ]]; then
    userUID=$((maxUID+1))
else
    userUID=501
fi    

# Create a local admin user account with the following attributes:
#
# Account shortname: admin
# Account's full name: Administrator
# UID: 501 or greater, depending on the maxUID variable
# Password: Set using the Mac VM's serial number
# Admin rights
#

sysadminctl -addUser "$shortname" -fullName "$fullname" -UID "$userUID" -password "$serial_number" -home /Users/"$shortname" -picture /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/UserIcon.icns -admin

# Force password change on first login

/usr/bin/pwpolicy -u "$shortname" -setpolicy "newPasswordRequired=1"

exit 0
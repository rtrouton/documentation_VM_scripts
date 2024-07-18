#!/bin/bash

machine_name=$(/usr/sbin/system_profiler SPHardwareDataType | awk '/Serial Number/ { print $4; }')

# Set Mac's hostname

/usr/sbin/scutil --set ComputerName "$machine_name"
/usr/sbin/scutil --set LocalHostName "$machine_name"
/usr/sbin/scutil --set HostName "$machine_name"

exit 0
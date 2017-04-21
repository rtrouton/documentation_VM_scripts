#!/bin/sh

#Primary Time server
                                                                  
TimeServer=time.apple.com

# Time zone for US East Coast

TimeZone=America/New_York

# Configure network time server and region

# Set the time zone
/usr/sbin/systemsetup -settimezone $TimeZone

# Set the primary network server with systemsetup -setnetworktimeserver

/usr/sbin/systemsetup -setnetworktimeserver $TimeServer

# Enables the Mac to set its clock using the network time server(s)

/usr/sbin/systemsetup -setusingnetworktime on

#!/bin/bash
 
# If any previous instances of the disablescreenshotdropshadow LaunchAgent and script exist,
# unload the LaunchAgent and remove the LaunchAgent and script files
 
if [[ -f "$3/Library/LaunchAgents/com.github.disablescreenshotdropshadow.plist" ]]; then
   /bin/launchctl unload "$3/Library/LaunchAgents/com.github.disablescreenshotdropshadow.plist"
   /bin/rm "$3/Library/LaunchAgents/com.github.disablescreenshotdropshadow.plist"
fi
 
if [[ -f "$3/Library/Scripts/disablescreenshotdropshadow.sh" ]]; then
   /bin/rm "$3/Library/Scripts/disablescreenshotdropshadow.sh"
fi
 
# Create the disablescreenshotdropshadow LaunchAgent by using cat input redirection
# to write the XML contained below to a new file.
#
# The LaunchAgent will run at load.
 
/bin/cat > "$3/tmp/com.github.disablescreenshotdropshadow.plist" << 'SCREENSHOT_DISABLE_DROPSHADOW_LAUNCHAGENT'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>com.github.disablescreenshotdropshadow</string>
	<key>ProgramArguments</key>
	<array>
		<string>sh</string>
		<string>/Library/Scripts/disablescreenshotdropshadow.sh</string>
	</array>
	<key>RunAtLoad</key>
	<true/>
</dict>
</plist>
SCREENSHOT_DISABLE_DROPSHADOW_LAUNCHAGENT
 
# Create the disablescreenshotdropshadow script by using cat input redirection
# to write the shell script contained below to a new file.
 
/bin/cat > "$3/tmp/disablescreenshotdropshadow.sh" << 'SCREENSHOT_DISABLE_DROPSHADOW_SCRIPT'
#!/bin/bash
 
# If screenshot dropshadows are not already disabled, disable 
# screenshot dropshadows and restart the SystemUIServer process.

screenshot_dropshadow_status=$(/usr/bin/defaults read "$HOME/Library/Preferences/com.apple.screencapture.plist" disable-shadow)

if [[ "$screenshot_dropshadow_status" != 1 ]]; then

    /usr/bin/defaults write "$HOME/Library/Preferences/com.apple.screencapture.plist" disable-shadow -bool true
    /usr/bin/killall SystemUIServer

fi
SCREENSHOT_DISABLE_DROPSHADOW_SCRIPT
 
# Once the LaunchAgent file has been created, fix the permissions
# so that the file is owned by root:wheel and set to not be executable
# After the permissions have been updated, move the LaunchAgent into 
# place in /Library/LaunchAgents.
 
/usr/sbin/chown root:wheel "$3/tmp/com.github.disablescreenshotdropshadow.plist"
/bin/chmod 755 "$3/tmp/com.github.disablescreenshotdropshadow.plist"
/bin/chmod a-x "$3/tmp/com.github.disablescreenshotdropshadow.plist"
/bin/mv "$3/tmp/com.github.disablescreenshotdropshadow.plist" "$3/Library/LaunchAgents/com.github.disablescreenshotdropshadow.plist"
 
# Once the script file has been created, fix the permissions
# so that the file is owned by root:wheel and set to be executable
# After the permissions have been updated, move the script into the
# place that it will be executed from.
 
/usr/sbin/chown root:wheel "$3/tmp/disablescreenshotdropshadow.sh"
/bin/chmod 755 "$3/tmp/disablescreenshotdropshadow.sh"
/bin/chmod a+x "$3/tmp/disablescreenshotdropshadow.sh"
/bin/mv "$3/tmp/disablescreenshotdropshadow.sh" "$3/Library/Scripts/disablescreenshotdropshadow.sh" 

exit 0
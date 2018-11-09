Payload-free package script which sets up a LaunchAgent and script which disables the drop shadow of screenshots.

Files installed:

* `/Library/LaunchAgents/com.github.disablescreenshotdropshadow.plist`
* `/Library/Scripts/disablescreenshotdropshadow.sh`

The LaunchAgent triggers the script to run on load. The script then takes the following actions:

1. Use the defaults command to see if `com.apple.screencapture`'s `disable-shadow` is set to `TRUE`.
2. If `com.apple.screencapture`'s `disable-shadow` is not set to `TRUE`:
	* Use the defaults command to set `com.apple.screencapture`'s `disable-shadow` value to `TRUE`
	* Restart the `SystemUIServer` process.

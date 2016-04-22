#!/bin/bash
# Very, very hacky way to do hot reload (browser sync)... but sometimes it is only one way to it
FILE=$1
BROWSER="Chromium"
EDITOR="Atom"

# echo "$(date --rfc-3339=seconds) Refresh: $FILE"
# CUR_WID=$(xdotool getwindowfocus)
#gets the first $BROWSER window, if you have more than one
#$BROWSER window open, it might not refresh the right one,
#as an alternative you can search by the window/html title
BROWSER_WID=$(xdotool search --onlyvisible --class $BROWSER|head -1)
xdotool windowactivate $BROWSER_WID && xdotool key 'ctrl+r'
#TITLE="window/html file title"
#WID=$(xdotool search --title "$TITLE"|head -1)
# sleep 0.7
EDITOR_WID=$(xdotool search --onlyvisible --class $EDITOR|head -1)
xdotool windowactivate $EDITOR_WID
# notify-send "refreshed"

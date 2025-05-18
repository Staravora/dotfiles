#!/bin/bash

# Create Screenshots directory if it doesn't exist
mkdir -p ~/Pictures/Screenshots

# Define the filename with timestamp
FILENAME=~/Pictures/Screenshots/screenshot_$(date +%Y%m%d_%H%M%S).png

# Take the screenshot of selected area
maim -s "$FILENAME"

# Check if screenshot was taken successfully
if [ $? -eq 0 ]; then
    # Copy to clipboard
    xclip -selection clipboard -t image/png < "$FILENAME"
    # Send notification
    notify-send "Screenshot saved" "File: $FILENAME" -i "$FILENAME"
fi

#!/bin/bash

# Find the device name for your touchpad
# This searches for a device with "touchpad" in its name.
DEVICE_NAME=$(hyprctl devices | grep -i "touchpad" | grep "Device:" | awk '{$1=""; print $0}' | sed 's/ (.*//;s/^ *//')

# Check if a touchpad device was found
if [ -z "$DEVICE_NAME" ]; then
    notify-send -u critical "Touchpad Toggle Failed" "No touchpad device found."
    exit 1
fi

# Get the current state (1 for enabled, 0 for disabled)
CURRENT_STATE=$(hyprctl getoption "device:$DEVICE_NAME:enabled" | grep "int:" | awk '{print $2}')

# Toggle the state
if [ "$CURRENT_STATE" == "1" ]; then
    hyprctl keyword "device:$DEVICE_NAME:enabled" false
    notify-send "Touchpad Disabled" "$DEVICE_NAME"
else
    hyprctl keyword "device:$DEVICE_NAME:enabled" true
    notify-send "Touchpad Enabled" "$DEVICE_NAME"
fi

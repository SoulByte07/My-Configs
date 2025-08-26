#!/usr/bin/env bash
#
# toggle-touchpad.sh (DEBUG VERSION)
#

TOUCHPAD="elan06fa:00-04f3:32b9-touchpad"

# Debug: Show current devices
echo "=== CURRENT DEVICES ==="
hyprctl devices

# Count external mice 
MOUSE_COUNT=0
while IFS= read -r line; do
    if [[ $line == "Mouse at"* ]]; then
        read -r name_line
        echo "Found device: $name_line"
        if [[ $name_line != *touchpad* ]]; then
            ((MOUSE_COUNT++))
            echo "  -> External mouse detected"
        fi
    fi
done < <(hyprctl devices)

echo "=== MOUSE COUNT: $MOUSE_COUNT ==="

# Try the correct syntax for newer Hyprland
if (( MOUSE_COUNT > 0 )); then
    echo "Disabling touchpad..."
    hyprctl keyword "device[$TOUCHPAD]:enabled" false
else
    echo "Enabling touchpad..."  
    hyprctl keyword "device[$TOUCHPAD]:enabled" true
fi

echo "=== RESULT ==="
hyprctl devices | grep -A2 "$TOUCHPAD"


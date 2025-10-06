#!/bin/bash

# Check if hyprsunset is running
if pgrep -x "hyprsunset" >/dev/null; then
    # Kill hyprsunset
    pkill hyprsunset
    # Send notification
    hyprctl notify 1 3000 "rgb(ff6b6b)" "Night Mode Disabled"
else
    # Start hyprsunset with warm temperature
    hyprsunset -t 4000 &
    # Send notification
    hyprctl notify 1 3000 "rgb(ffa500)" "Night Mode Enabled (4000K)"
fi


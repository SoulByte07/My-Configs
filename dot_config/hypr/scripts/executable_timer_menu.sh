#!/bin/bash

TIMER_SCRIPT="$HOME/.config/hypr/scripts/timer.sh"

# Rofi menu options
entries="5 Minutes\n15 Minutes\n25 Minutes (Pomodoro)\n45 Minutes\nStop Timer"

# Show rofi menu and get selected option
# We replace 'wofi --dmenu --prompt' with 'rofi -dmenu -p'
selected=$(echo -e "$entries" | rofi -dmenu -p "Set Timer:")

# Execute action based on selection
case "$selected" in
    "5 Minutes")
        "$TIMER_SCRIPT" start 5
        ;;
    "15 Minutes")
        "$TIMER_SCRIPT" start 15
        ;;
    "25 Minutes (Pomodoro)")
        "$TIMER_SCRIPT" start 25
        ;;
    "45 Minutes")
        "$TIMER_SCRIPT" start 45
        ;;
    "Stop Timer")
        "$TIMER_SCRIPT" stop
        ;;
esac

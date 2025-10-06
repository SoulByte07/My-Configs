#!/bin/bash

TIMER_SCRIPT="$HOME/.config/hypr/scripts/timer.sh"

# Wofi menu options
entries="5 Minutes\n15 Minutes\n25 Minutes (Pomodoro)\n45 Minutes\nStop Timer"

# Show wofi menu and get selected option
selected=$(echo -e "$entries" | wofi --dmenu --prompt "Set Timer:")

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

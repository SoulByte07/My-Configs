#!/bin/bash

# The file where we store the timer's end time
END_TIME_FILE="/tmp/waybar_timer_end_time"

# --- Functions ---

# Function to start the timer
start_timer() {
    local minutes=$1
    if ! [[ "$minutes" =~ ^[0-9]+$ ]]; then
        echo "Invalid input: Please provide minutes as a number."
        exit 1
    fi

    local end_time=$(( $(date +%s) + minutes * 60 ))
    echo "$end_time" > "$END_TIME_FILE"
    notify-send "Timer Started" "Timer set for ${minutes} minutes."
}

# Function to stop the timer
stop_timer() {
    rm -f "$END_TIME_FILE"
    notify-send "Timer Stopped"
}

# Function to display the time
display_time() {
    if [ ! -f "$END_TIME_FILE" ]; then
        # No timer is running
        echo '{"text": "", "tooltip": "No timer running", "class": "idle"}'
        exit 0
    fi

    local end_time=$(cat "$END_TIME_FILE")
    local current_time=$(date +%s)
    local remaining_seconds=$(( end_time - current_time ))

    if [ "$remaining_seconds" -gt 0 ]; then
        # Timer is running
        local minutes=$(( remaining_seconds / 60 ))
        local seconds=$(( remaining_seconds % 60 ))
        printf '{"text": "  %02d:%02d", "tooltip": "Time Remaining: %d minutes", "class": "active"}\n' "$minutes" "$seconds" "$minutes"
    else
        # Timer has ended
        notify-send -u critical "Timer Finished!" "Your task time is up."
        # Optional: Add a sound notification
        # paplay /usr/share/sounds/freedesktop/stereo/complete.oga
        stop_timer
        echo '{"text": "", "tooltip": "No timer running", "class": "idle"}'
    fi
}

# --- Main Logic ---
# Check for arguments (start, stop)
case "$1" in
    start)
        start_timer "$2"
        ;;
    stop)
        stop_timer
        ;;
    *)
        # If no argument, just display the time for Waybar
        display_time
        ;;
esac

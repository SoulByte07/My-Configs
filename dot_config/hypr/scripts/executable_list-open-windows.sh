#!/usr/bin/env bash
# ~/.config/hypr/scripts/list-open-windows.sh

hyprctl clients -j \
  | jq -c '
    map({
      text: (
        if .class == "firefox" then ""
        elif .class == "kitty"   then ""
        elif .class == "thunar"  then ""
        elif .class == "code"    then ""
        else                       ""
        end
      ),
      "on-click": ("hyprctl dispatch focuswindow " + (.address|tostring)),
      class:     (if .focused then "focused-app" else "app" end)
    })
  '


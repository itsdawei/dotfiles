#!/bin/sh

toggle_scratchpad() {
  ws_name="$1"
  cmd="$2"

  windows=$(hyprctl clients -j | jq ".[] | select(.workspace.name == \"special:$ws_name\" )")
  if [ -z "$windows" ]; then
    hyprctl dispatch "exec [workspace special:$ws_name] $cmd"
  else
    hyprctl dispatch togglespecialworkspace "$ws_name"
  fi
}


toggle_scratchpad "$1" "$2"

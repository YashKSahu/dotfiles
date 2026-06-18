#!/usr/bin/env bash

update() {
  # Instantly check hardware state by tracking interface IP
  IP_ADDR=$(ipconfig getifaddr en0)

  if [ -n "$IP_ADDR" ]; then
    ICON="󰤨"
    COLOR="0xffffffff"

    # Extract unredacted Network Name from local preferred list cache
    SSID=$(networksetup -listpreferredwirelessnetworks en0 | awk 'NR==2 {sub(/^[ \t]+/, ""); print}')
    [ -z "$SSID" ] && SSID="Online"
  else
    SSID="Disconnected"
    ICON="󰤮"
    COLOR="0x44ffffff"
  fi

  # Handle the Floating Cloud Popup
  if [ "$SENDER" = "mouse.entered" ]; then
    sketchybar --set "wifi.tooltip" label="$SSID" \
               --set "$NAME" popup.drawing=on
  elif [ "$SENDER" = "mouse.exited" ] || [ "$SENDER" = "mouse.exited.global" ]; then
    sketchybar --set "$NAME" popup.drawing=off
  fi

  # Update icon states
  sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR"
}

# Only run for network changes or hover actions
case "$SENDER" in
  "wifi_change"|"forced"|"mouse.entered"|"mouse.exited"|"mouse.exited.global")
    update
    ;;
esac
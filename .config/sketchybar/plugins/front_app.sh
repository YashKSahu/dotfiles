#!/bin/sh

# Function to handle UI updates
update_app() {
  local new_icon="$1"
  local new_label="$2"
  
  if [ -z "$new_label" ]; then
    # CLOSING: Keep the smooth animated collapse
    sketchybar --animate tanh 15 --set "$NAME" \
      icon.width=0 \
      label.width=0 \
      padding_left=0 \
      icon.padding_right=0 \
      label.padding_right=0
  else
    # OPENING: Instant transition (no animation flag)
    sketchybar --set "$NAME" \
      icon="$new_icon" \
      label="$new_label" \
      icon.width=dynamic \
      label.width=dynamic \
      padding_left=15 \
      icon.padding_right=8 \
      label.padding_right=4
  fi
}

if [ "$SENDER" = "aerospace_workspace_change" ]; then
  FOCUSED=$(aerospace list-workspaces --focused 2>/dev/null)
  WINDOWS=$(aerospace list-windows --workspace "$FOCUSED" 2>/dev/null)

  if [ -z "$WINDOWS" ]; then
    update_app "" ""
  else
    FRONT_APP=$(aerospace list-windows --focused --format "%{app-name}" 2>/dev/null)
    if [ -z "$FRONT_APP" ]; then
      FRONT_APP=$(aerospace list-windows --workspace "$FOCUSED" --format "%{app-name}" 2>/dev/null | head -n 1)
    fi

    if [ -n "$FRONT_APP" ]; then
      ICON=$("$CONFIG_DIR/plugins/icon_map.sh" "$FRONT_APP")
      update_app "$ICON" "$FRONT_APP"
    fi
  fi
  exit 0
fi

if [ "$SENDER" = "front_app_switched" ]; then
  if [ -z "$INFO" ]; then
    update_app "" ""
    exit 0
  fi

  ICON=$("$CONFIG_DIR/plugins/icon_map.sh" "$INFO")
  update_app "$ICON" "$INFO"
  exit 0
fi
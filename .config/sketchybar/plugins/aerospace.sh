#!/bin/bash

ACTIVE_WORKSPACES=$(aerospace list-workspaces --all)

VISIBLE=off
for ws in $ACTIVE_WORKSPACES; do
  if [ "$ws" = "$NAME" ]; then
    VISIBLE=on
    break
  fi
done

if [ "$VISIBLE" = "off" ]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

if [ "$FOCUSED_WORKSPACE" = "$NAME" ]; then
  sketchybar --set "$NAME" \
    drawing=on \
    background.drawing=on \
    background.color=0x80ffffff \
    icon.color=0xff000000
else
  sketchybar --set "$NAME" \
    drawing=on \
    background.drawing=off \
    icon.color=0xff000000
fi
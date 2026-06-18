#!/bin/bash

FOCUSED=$(aerospace list-workspaces --focused)

if [ "$FOCUSED" = "$SID" ]; then
    sketchybar --set "$NAME" background.drawing=on
else
    sketchybar --set "$NAME" background.drawing=off
fi
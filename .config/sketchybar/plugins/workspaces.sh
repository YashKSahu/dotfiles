#!/bin/bash

sketchybar --remove '/workspace\..*/'

for ws in $(aerospace list-workspaces --all); do
  sketchybar --add item workspace.$ws left \
             --set workspace.$ws \
             icon="$ws" \
             label.drawing=off \
             click_script="aerospace workspace $ws"
done
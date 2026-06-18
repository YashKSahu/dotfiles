#!/bin/bash

# Pull the massive stats string, locate Device Utilization %, and isolate its value
GPU_USAGE=$(ioreg -r -c AGXAccelerator | awk -F'"Device Utilization %"=' '{print $2}' | awk -F',' '{print $1}' | tr -d '[:space:]')

# Fallback to 0 if something goes sideways
if [ -z "$GPU_USAGE" ]; then
  GPU_USAGE=0
fi

sketchybar --set "$NAME" \
           icon.font="sketchybar-app-font:Regular:24.0" \
           label="${GPU_USAGE}%"
#!/bin/bash

# Extract CPU usage over a quick sample, stripping the '%' signs so awk can do the math properly
CPU_USAGE=$(top -l 2 -n 0 -F | grep "CPU usage" | tail -1 | awk '{
  sub(/%/, "", $3); 
  sub(/%/, "", $5); 
  printf "%d%%", $3 + $5
}')

sketchybar --set "$NAME" label="$CPU_USAGE"
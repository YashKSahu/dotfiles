#!/bin/sh

# Fetches the format: Fri, 05 Jun 10:56 AM
LABEL=$(date '+%a %d %b %I:%M %p')

sketchybar --set "$NAME" label="$LABEL"
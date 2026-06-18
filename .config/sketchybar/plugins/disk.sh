#!/bin/bash

# Target the data partition directly where all your files live
DISK_INFO=$(df -h /System/Volumes/Data | tail -1)

# df -h gives us "397Gi". We strip the "Gi" suffix out.
AVAIL_GIB=$(echo "$DISK_INFO" | awk '{print $4}' | tr -d 'G|i')

# Total capacity is 460GiB. 460 - 397 = 63GiB used.
USED_GIB=$((460 - AVAIL_GIB))

# Convert Binary GiB back to standard human-readable Decimal GB (Multiply by ~1.074)
USED_GB=$(awk -v gib="$USED_GIB" 'BEGIN {printf "%.0f", gib * 1.074}')
AVAIL_GB=$(awk -v gib="$AVAIL_GIB" 'BEGIN {printf "%.0f", gib * 1.074}')

sketchybar --set "$NAME" label="${USED_GB}GB"
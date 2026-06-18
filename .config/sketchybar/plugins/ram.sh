#!/bin/bash

# 1. Fetch system constants (Total RAM in Bytes and Core Page Size)
MEM_TOTAL_BYTES=$(sysctl -n hw.memsize)
PAGE_SIZE=$(vm_stat | grep "page size" | awk '{print $8}')

# 2. Parse active pages out of vm_stat
PAGES_FREE=$(vm_stat | grep "Pages free:" | awk '{print $3}' | tr -d '.')
PAGES_SPEC=$(vm_stat | grep "Pages speculative:" | awk '{print $3}' | tr -d '.')
PAGES_CACHE=$(vm_stat | grep "File-backed pages:" | awk '{print $4}' | tr -d '.')

# 3. Available Memory = Completely Free + Speculative + File Cache
MEM_AVAILABLE_BYTES=$(( (PAGES_FREE + PAGES_SPEC + PAGES_CACHE) * PAGE_SIZE ))

# 4. Calculate actual App/Wired Used Memory
MEM_USED_BYTES=$(( MEM_TOTAL_BYTES - MEM_AVAILABLE_BYTES ))

# 5. Calculate units (GB Used and Percentage)
USED_GB=$(awk -v used="$MEM_USED_BYTES" 'BEGIN {printf "%.1f", used / 1024 / 1024 / 1024}')
TOTAL_GB=$(( MEM_TOTAL_BYTES / 1024 / 1024 / 1024 ))
PERCENT=$(( (MEM_USED_BYTES * 100) / MEM_TOTAL_BYTES ))

# 6. Push to SketchyBar (Format: 11.2GB (69%))
sketchybar --set "$NAME" label="${USED_GB}GB"
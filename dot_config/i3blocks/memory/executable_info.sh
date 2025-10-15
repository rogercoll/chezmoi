#!/usr/bin/env bash

case $BLOCK_BUTTON in
	1 | 2 | 3)
        notify-send "$icon Memory hogs (%)" "$(ps axch -o cmd:10,pmem k -pmem | head | awk '$0=$0' )"
        ;;
esac

# i3blocks memory script
# Shows: MEM: used/total% @ swap MB

# Get memory info from /proc/meminfo
mem_total=$(grep MemTotal /proc/meminfo | awk '{print $2}')
mem_avail=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
swap_total=$(grep SwapTotal /proc/meminfo | awk '{print $2}')
swap_free=$(grep SwapFree /proc/meminfo | awk '{print $2}')

# Convert kB to MB
mem_total_mb=$((mem_total / 1024))
mem_avail_mb=$((mem_avail / 1024))
swap_used_mb=$(((swap_total - swap_free) / 1024))

# Calculate used percentage
mem_used_percent=$(( (100 * (mem_total - mem_avail)) / mem_total ))

# Slightly brighter colors for better visibility on the bar
if [ "$mem_used_percent" -lt 10 ]; then
    color="#7FD67F"    # brighter soft green
elif [ "$mem_used_percent" -lt 50 ]; then
    color="#E5E58C"    # gentle yellow
elif [ "$mem_used_percent" -lt 80 ]; then
    color="#F0B46A"    # brighter orange
else
    color="#EF7A7A"    # brighter soft red
fi

# Print output for i3blocks
echo " MEM: ${mem_used_percent}% @ ${swap_used_mb}MB "
echo
echo "$color"

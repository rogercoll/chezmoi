#!/usr/bin/env bash
# i3blocks script: Power Profile switcher
# Cycles through power profiles on click and shows an icon for current mode.

get_current_profile() {
    powerprofilesctl get
}

set_next_profile() {
    current=$(get_current_profile)
    case "$current" in
        power-saver)
            powerprofilesctl set balanced
            ;;
        balanced)
            powerprofilesctl set performance
            ;;
        performance)
            powerprofilesctl set power-saver
            ;;
        *)
            powerprofilesctl set balanced
            ;;
    esac
}

get_icon() {
    current="$1"
    case "$current" in
        power-saver)
            echo "♻️"  # recycle symbol
            ;;
        balanced)
            echo "⚖️"  # balance scale
            ;;
        performance)
            echo "⚡️"  # lightning bolt
            ;;
        *)
            echo "❓"
            ;;
    esac
}

case $BLOCK_BUTTON in
    1) set_next_profile ;;  # left click cycles modes
esac

current=$(get_current_profile)
icon=$(get_icon "$current")

# Output for i3blocks: full text and short text
echo "$icon"
echo "$icon $current"

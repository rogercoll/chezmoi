#!/bin/sh
case $BLOCK_BUTTON in
    1 | 2 | 3)
        notify-send "$icon CPU hogs (%)" "$(
            ps axch -o cmd:10,pcpu k -pcpu \
            | grep -v '^ps\b' \
            | head \
            | awk '$0=$0'
        )"
        ;;
esac

TEMP=$(sensors | grep 'Package id 0:\|Tdie' | grep ':[ ]*+[0-9]*.[0-9]*°C' -o | grep '+[0-9]*.[0-9]*°C' -o)
CPU_USAGE=$(mpstat 1 1 | awk '/Average:/ {printf("%s\n", $(NF-9))}')
echo "$CPU_USAGE $TEMP" | awk '{ printf(" CPU:%6s% @ %s \n"), $1, $2 }'

#!/usr/bin/env bash

case $BLOCK_BUTTON in
	1 | 2 | 3)
        notify-send "$icon Memory hogs (%)" "$(ps axch -o cmd:10,pmem k -pmem | head | awk '$0=$0' )"
        ;;
esac

free -h | awk '/Mem:/ { printf(" 🐏 %5s \n", $7) }'

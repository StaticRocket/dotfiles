#!/bin/sh

PROMPT="Screenshot..."
OPTIONS="\
1. Selection
2. Active Window
3. Active Screen
4. All Outputs
"

MODE=$(printf "%s" "$OPTIONS" | wofi -d -p $PROMPT -O alphabetical)

case $MODE in
	"1. Selection")
		grim -g "$(slurp)" "$@"
		;;
	"2. Active Window")
		grim -g "$(swaymsg -t get_tree | jq -r '.. | select(.focused?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"')" "$@"
		;;
	"3. Active Screen")
		grim -g "$(swaymsg -t get_outputs | jq -r '.. | select(.focused?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"')" "$@"
		;;
	"4. All Outputs")
		grim "$@"
		;;
esac

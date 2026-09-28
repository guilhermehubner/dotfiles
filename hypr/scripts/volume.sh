#!/bin/sh
# Change volume on the default output and show a notification.
# Usage: volume.sh up|down|mute

sink=@DEFAULT_AUDIO_SINK@

case "$1" in
    up) wpctl set-volume -l 1.0 "$sink" 5%+ ;; # -l 1.0 caps at 100%
    down) wpctl set-volume "$sink" 5%- ;;
    mute) wpctl set-mute "$sink" toggle ;;
    *)
        echo "usage: $0 up|down|mute" >&2
        exit 1
        ;;
esac

# wpctl prints e.g. "Volume: 0.45" or "Volume: 0.45 [MUTED]"
status=$(wpctl get-volume "$sink")
percent=$(echo "$status" | awk '{ print int($2 * 100 + 0.5) }')

case "$status" in
    *MUTED*) title=muted ;;
    *) title=volume ;;
esac

notify-send \
    -h string:x-dunst-stack-tag:volume \
    -h string:synchronous:volume \
    -h int:value:"$percent" \
    -i ~/.icons/Wings-Dark-Icons/actions/16/player-volume.svg \
    -t 500 \
    "$title"

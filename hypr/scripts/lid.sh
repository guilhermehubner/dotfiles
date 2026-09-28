#!/bin/sh
# Handle the laptop lid.
# Usage: lid.sh open|close

case "$1" in
    open)
        # Re-read the config, which re-applies the monitor lines in monitors.conf
        # (exec-once programs are not started again).
        hyprctl reload
        ;;
    close)
        # Only turn the laptop screen off if another monitor is connected. Otherwise leave it
        # on, so the lid switch suspends the machine (logind) instead of leaving no screen.
        if hyprctl monitors | grep '^Monitor' | grep -qv 'eDP-'; then
            for monitor in eDP-1 eDP-2; do
                hyprctl keyword monitor "$monitor, disable"
            done
        fi
        ;;
    *)
        echo "usage: $0 open|close" >&2
        exit 1
        ;;
esac

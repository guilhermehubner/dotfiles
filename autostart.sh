#!/bin/bash

case `cat /proc/acpi/button/lid/LID0/state` in
	*"closed"*)
		xrandr --output eDP-1 --off;;
	*"open"*)
		xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --mode 1920x1080 --pos 1920x0 --rotate normal;;
esac

picom -f &

~/.fehbg &

dunst &

~/.dwm/dwmwatcher.sh &

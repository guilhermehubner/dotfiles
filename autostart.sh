#!/bin/bash

case `cat /proc/acpi/button/lid/LID0/state` in
	*"closed"*)
		xrandr --output eDP-1 --off;;
	*"open"*)
		xrandr --output eDP-1 --auto --same-as HDMI-1 --left-of HDMI-1;;
esac

picom -f &

~/.fehbg &

~/.dwm/dwmwatcher.sh &

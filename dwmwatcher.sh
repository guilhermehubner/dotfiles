#!/bin/bash

update_status() {
	TIME=`date +'%a %d %b %H:%M'`
	VOLUME=`pamixer --get-volume | tr -d '\n'`
	WIFI=`iwgetid -r`
	BATTERY=`acpi | cut -d: -f2- | cut -d, -f2 | tr -d '% '`

	xsetroot -name "  $VOLUME |  $WIFI |  $BATTERY | $TIME"
}

update_mons() {
	case `cat /proc/acpi/button/lid/LID0/state` in
		*"closed"*)
			xrandr --output eDP-1 --off;;
		*"open"*)
			xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --mode 1920x1080 --pos 1920x0 --rotate normal;;
	esac
}

trap 'killall dwmwatcher.sh' EXIT

pactl subscribe | grep --line-buffered "sink" | grep --line-buffered -v "sink-input" | while read line;
do
	dunstify -r 2593 -I ~/.icons/Dracula/actions/16/player-volume.svg -t 800 -h int:value:`pamixer --get-volume | tr -d '\n'` volume

	update_status
done &

iwevent | while read line; do update_status; done &

acpi_listen | while IFS= read -r line;
do
	case $line in
		*"button/lid"*)
			update_mons
	esac
done &

update_status

while :; do
	update_status

	sleep 1m
done

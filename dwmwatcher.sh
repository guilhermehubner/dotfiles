#!/bin/bash

update_status() {
	TIME=`date +'%a %d %b %H:%M'`
	VOLUME=`pamixer --get-volume | tr -d '\n'`
	WIFI=`iwgetid -r`

	xsetroot -name "  $VOLUME |  $WIFI | $TIME"
}

update_mons() {
	case `cat /proc/acpi/button/lid/LID0/state` in
		*"closed"*)
			xrandr --output eDP-1 --off;;
		*"open"*)
			xrandr --output eDP-1 --auto --same-as HDMI-1 --left-of HDMI-1;;
	esac
}

pactl subscribe | grep --line-buffered "sink" | while read line;
do
	dunstify -I ~/.icons/Dracula/actions/16/player-volume.svg -t 800 -h int:value:`pamixer --get-volume | tr -d '\n'` volume

	update_status
done&

iwevent | while read line; do update_status; done&

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

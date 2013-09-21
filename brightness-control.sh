#/!bin/bash

brightness=`cat /sys/class/backlight/psb-bl/brightness`

increment=5

if [ "$1" == + ]; then
	if [ $brightness -lt 100 ]; then
		brightness=$[$brightness + $increment]
	fi
elif [ "$1" == - ]; then
	if [ $brightness -gt 0 ]; then
		brightness=$[$brightness - $increment]
	fi
else
	exit 0;
fi

echo $brightness > /sys/class/backlight/psb-bl/brightness

notify-send "brightness: $brightness"

#!/bin/sh
wal -R 

amixer set Master 0

picom & disown

while true; do
	xsetroot -name "$(echo $(echo"|"; iw dev wlp8s0 link | grep -i SSID; echo "|"; echo bat:; cat /sys/class/power_supply/BAT0/capacity; echo %; echo "|"; echo "vol:"; amixer get Master | grep -o --max-count=1 "[0-9]*%"; echo "|"; date))"
	sleep 1
done & disown 

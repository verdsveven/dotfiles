#!/bin/sh
wal -R 

amixer set Master 0

picom & disown

while true; do
	xsetroot -name "$(echo $(echo "|";echo "wifi: `iw dev wlp8s0 link | grep -i SSID | sed -n -e 's/^.*SSID: //p'` |"; 
	echo "bat: `cat /sys/class/power_supply/BAT0/capacity`%, `cat /sys/class/power_supply/BAT0/status`"; 
	echo "| vol:"; amixer get Master | grep -o --max-count=1 "[0-9]*%"; 
	echo "| lang:"; 
	cat /etc/vconsole.conf | grep -o "[a-z][a-z]"; 
	echo "|"; 
	date))"
	sleep 1
done & disown 

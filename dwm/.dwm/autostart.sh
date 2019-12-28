#!/usr/bin/env sh

wal -R & 

picom --config ~/.config/picom/picom.conf &

amixer set Master 0 &

status() { \
	echo "|";
	echo "wifi: `iw dev wlp8s0 link | sed -n -e 's/^.*SSID: //p'` |"; 
	echo "bat: `cat /sys/class/power_supply/BAT0/capacity`%, `cat /sys/class/power_supply/BAT0/status`"; 
	echo "| vol: `amixer get Master | grep -o --max-count=1 "[0-9]*%"`"; 
	echo "| lang: `setxkbmap -print -v 10 | sed -n -e 's/^.*layout:     //p'`"; 
	echo "| `date`"; 
}

update() { \
	xsetroot -name "$(status | tr '\n' ' ')" &
    }

while true; do
	update
	sleep 1s
done & 

#!/bin/sh
network(){
	#iw dev wlp8s0 link | sed -n -e 's/^.*SSID: //p'
	nmcli -f NAME c show --active | sed -n 2p | awk '{$1=$1};1'
}

bat(){
	cap=`cat /sys/class/power_supply/BAT0/capacity`
	stat=`cat /sys/class/power_supply/BAT0/status`
	( [ -z $cap -o -z $stat ] && echo "No battery" ) || echo "$cap%, $stat"
}

lux(){
	( which light || echo none ) && echo `light -G`%
}

vol(){
	amixer get Master | grep -o --max-count=1 "[0-9]*%"
}

lang(){
	setxkbmap -print -v 10 | sed -n -e 's/^.*layout:     //p'
}

case $1 in
	network) network ;;
	bat) bat ;;
	lux) lux ;;
	vol) vol ;;
	lang) lang ;;
	date) date +%c ;;
	lux) lux ;;
esac

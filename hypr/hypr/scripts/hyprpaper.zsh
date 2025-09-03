#!/usr/bin/zsh

INTERVAL=$2

while true; do
	
	wallpaper=$(find -L $1 -type f | shuf -n 1)
	
	hyprctl hyprpaper preload "$wallpaper"
	hyprctl hyprpaper wallpaper "DP-1,$wallpaper"
	hyprctl hyprpaper wallpaper "DP-2,$wallpaper"

	sleep 5
	hyprctl hyprpaper unload "$wallpaper"
	
	sleep $INTERVAL
done

#!/bin/zsh

hyprctl devices -j |
	jq -r '.keyboards[] | .active_keymap' |
	head -n1 |
	cut -c1-

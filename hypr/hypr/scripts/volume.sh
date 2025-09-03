#!/usr/bin/env bash

iDIR="$HOME/.config/mako/icons"

# Get Volume
get_volume() {
  volume=$(wpctl get-volume @DEFAULT_SINK@ | grep -oE "[0-9][.][0-9]+")
  echo $(awk "BEGIN {print $volume * 100}")
}

# Get icons
get_icon() {
  current=$(get_volume)
  if [[ "$current" -eq "0" ]]; then
    echo "$iDIR/volume-mute.png"
  elif [[ ("$current" -ge "0") && ("$current" -le "30") ]]; then
    echo "$iDIR/volume-low.png"
  elif [[ ("$current" -ge "30") && ("$current" -le "60") ]]; then
    echo "$iDIR/volume-mid.png"
  elif [[ ("$current" -ge "60") && ("$current" -le "100") ]]; then
    echo "$iDIR/volume-high.png"
  fi
}

# Notify
notify_user() {
  notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$(get_icon)" "Volume : $(get_volume) %"
}

# Increase Volume
inc_volume() {
  wpctl set-volume @DEFAULT_SINK@ 5%+ && notify_user
}

# Decrease Volume
dec_volume() {
  wpctl set-volume @DEFAULT_SINK@ 5%- && notify_user
}

# Toggle Mute
toggle_mute() {
  if [[$(wpctl get-volume @DEFAULT_SINK@) =~ "MUTED" ]]; then
    wpctl set-mute @DEFAULT_SINK@ 0 && notify-send -c audio -h string:x-canonical-private-synchronous:sys-notify -u low -i "$iDIR/volume.png" "Volume Switched ON"
  else
    wpctl set-mute @DEFAULT_SINK@ 1 && notify-send -c audio -h string:x-canonical-private-synchronous:sys-notify -u low -i "$(get_icon)" "Volume Switched OFF"
  fi
}

# Toggle Mic
toggle_mic() {
  if [[ "$(wpctl get-volume @DEFAULT_SOURCE@)" =~ "MUTED" ]]; then
    pamixer --default-source -m && notify-send -c audio -h string:x-canonical-private-synchronous:sys-notify -u low -i "$iDIR/microphone.png" "Microphone Switched ON"
  else
    pamixer -u --default-source u && notify-send -c audio -h string:x-canonical-private-synchronous:sys-notify -u low -i "$iDIR/microphone-mute.png" "Microphone Switched OFF"
  fi
}
# Get icons
get_mic_icon() {
  current=$(wpctl get-volume @DEFAULT_SOURCE@ | grep -oE "[0-9][.][0-9]+")
  current=$(awk "BEGIN {print $current * 100}")
  if [[ "$current" -eq "0" ]]; then
    echo "$iDIR/microphone.png"
  elif [[ ("$current" -ge "0") && ("$current" -le "30") ]]; then
    echo "$iDIR/microphone.png"
  elif [[ ("$current" -ge "30") && ("$current" -le "60") ]]; then
    echo "$iDIR/microphone.png"
  elif [[ ("$current" -ge "60") && ("$current" -le "100") ]]; then
    echo "$iDIR/microphone.png"
  fi
}
# Notify
notify_mic_user() {
  notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$(get_mic_icon)" "Mic-Level : $(pamixer --default-source --get-volume) %"
}

# Increase MIC Volume
inc_mic_volume() {
  wpctl set-volume @DEFAULT_SOURCE@ 5%+ && notify_mic_user
}

# Decrease MIC Volume
dec_mic_volume() {
  wpctl set-volume @DEFAULT_SOURCE@ 5%- && notify_mic_user
}

# Execute accordingly
if [[ "$1" == "--get" ]]; then
  get_volume
elif [[ "$1" == "--inc" ]]; then
  inc_volume
elif [[ "$1" == "--dec" ]]; then
  dec_volume
elif [[ "$1" == "--toggle" ]]; then
  toggle_mute
elif [[ "$1" == "--toggle-mic" ]]; then
  toggle_mic
elif [[ "$1" == "--get-icon" ]]; then
  get_icon
elif [[ "$1" == "--get-mic-icon" ]]; then
  get_mic_icon
elif [[ "$1" == "--mic-inc" ]]; then
  inc_mic_volume
elif [[ "$1" == "--mic-dec" ]]; then
  dec_mic_volume
else
  get_volume
fi

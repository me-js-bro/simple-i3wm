#!/bin/bash

"$HOME/.config/polybar/launch.sh" #polybar
feh --bg-scale "$HOME/.config/i3/.cache/current.png" #wallpaper
"$HOME/.config/i3/scripts/pywal.sh"
"$HOME/.config/i3/scripts/polkit.sh"

keyboard="/usr/share/openbangla-keyboard"
if [[ -d "$keyboard" ]]; then
    fcitx5 & #fcitx5 if openbangla keyboard is installed
fi

xrandr --output HDMI-1 --mode 1920x1080 --rate 75

greenclip daemon
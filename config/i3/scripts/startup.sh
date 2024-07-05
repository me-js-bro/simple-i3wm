#!/bin/bash

"$HOME/.config/polybar/launch.sh" #polybar
feh --bg-scale "$HOME/.config/i3/.cache/current.png" #wallpaper
dunst & #dunst
picom & #picom


keyboard="/usr/share/openbangla-keyboard"
if [[ -d "$keyboard" ]]; then
    fcitx5 & #fcitx5 if openbangla keyboard is installed
fi
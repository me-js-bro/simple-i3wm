#!/bin/bash

"$HOME/.config/polybar/launch.sh" #polybar
feh --bg-scale "$HOME/.config/i3/.cache/current.png" #wallpaper
"$HOME/.config/i3/scripts/pywal.sh"
"$HOME/.config/i3/scripts/polkit.sh"

if [[ -d "/usr/share/openbangla-keyboard" ]]; then
    fcitx5 & #fcitx5 if openbangla keyboard is installed
fi

picom
greenclip daemon
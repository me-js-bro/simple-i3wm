#!/bin/bash

polybar="$HOME/.config/polybar/launch.sh"
pkgs=(
    dunst
    polybar
)

# restarting dunst
for pkg in "${pkgs[@]}"; do
    if pidof "$pkg"; then
        killall "$pkg"
    fi
done

# launch the polybar
$polybar
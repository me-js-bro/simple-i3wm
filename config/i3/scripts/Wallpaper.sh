#!/bin/bash

i3_dir="$HOME/.config/i3"
scripts_dir="$i3_dir/scripts"
cache_dir="$i3_dir/.cache"
theme_file="$cache_dir/theme"

if [[ -f "$theme_file" ]]; then
    source "$theme_file"
fi

wallpaper_dir="$i3_dir/wallpapers/$current"

pics=($(find ${wallpaper_dir} -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \)))
random_pic=${pics[ $RANDOM % ${#pics[@]} ]}

# functions to change wallpaper using feh
change() {
    if command -v feh &> /dev/null; then
        engine="feh --bg-scale $1"
    fi

    notify-send "Changing to" -i "$random_pic"
    sleep 1
    $engine "$random_pic"
    ln -sf "$random_pic" "$cache_dir/current.png"
    rm -r "$HOME/.cache/wal"
}

change

sleep 0.2
"$scripts_dir/pywal.sh"

sleep 0.2
"$scripts_dir/Refresh.sh"
#!/bin/bash

dir="$HOME/.config/polybar/"
bar_file="$dir/.bar"
rofi_menu="$HOME/.config/rofi/menu/style-2.rasi"
rofi_poer_menu="$HOME/.config/rofi/power_option/style-4.rasi"
bar=$(cat "$bar_file")

case $1 in
    "top") echo "Top" > "$bar_file"
            sed -i "s/location:.*/location: northWest;/g" "$rofi_menu"
            sed -i "s/y-offset:.*/y-offset: 50px;/g" "$rofi_menu"

            sed -i "s/location:.*/location: northeast;/g" "$rofi_poer_menu"
            sed -i "s/anchor:.*/anchor: northeast;/g" "$rofi_poer_menu"
            sed -i "s/y-offset:.*/y-offset: 50px;/g" "$rofi_poer_menu"
        ;;
    "bottom") echo "Bottom" > "$bar_file"
            sed -i "s/location:.*/location: southWest;/g" "$rofi_menu"
            sed -i "s/y-offset:.*/y-offset: -50px;/g" "$rofi_menu"

            sed -i "s/location:.*/location: southeast;/g" "$rofi_poer_menu"
            sed -i "s/anchor:.*/anchor: southeast;/g" "$rofi_poer_menu"
            sed -i "s/y-offset:.*/y-offset: -50px;/g" "$rofi_poer_menu"
        ;;
    *) polybar bar$(cat "$bar_file") &
        ;;
esac

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar bar$(cat "$bar_file") &

echo "Polybar launched..."

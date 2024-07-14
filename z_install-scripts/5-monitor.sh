#!/bin/bash

# log files
dir="$(dirname "$(realpath "$0")")"
parent_dir="$(dirname "$dir")"
log_dir="$parent_dir/Logs"
log="$log_dir/monitor_$(date +%d-%m-%y_).log"
mkdir -p "$log_dir" && touch "$log"

source "$dir/00-global.sh"


monitor=($(xrandr -q | grep " connected" | cut -d ' ' -f1))

X=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f1)
Y=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f2)

res=${X}x${Y}
info qs "Is your monitor resolution${orange} ${res}p ${end}? [ y/n ]"
read -r -p "$(echo -e '\e[1;32m  Select: \e[1;0m')" size

if [[ "$size" =~ ^[Yy]$ ]]; then

    info qs "What is your monitor supported refresh rate? ${orange}\n  1) 60Hz \n  2) 75Hz \n  3) 144Hz${end}\n"
    read -r -p "$(echo -e '\e[1;32mSelect: \e[1;0m')" refresh
    case $refresh in
        1) hz="60"
            ;;
        2) hz="75"
            ;;
        3) hz="144"
            ;;
        *) info nt "Select from 1, 2 or 3"
            ;;
    esac

    info ac "${yellow}Setting your monitor resolution and refresh rate to ${res}p ${hz}Hz ${end}\n"
    sleep 2
    # xrandr --output $monitor --mode $res --rate $hz 2>&1 | tee -a "$log"

    startup="$HOME/.config/i3/scripts/startup.sh"
    if ! grep -q "xrandr --output $monitor --mode $res --rate $hz" "$startup"; then
        echo -e "\nxrandr --output $monitor --mode $res --rate $hz" >> "$startup"
        info dn "Monitor setup command added to startup script." 
    else
        info at "Monitor setup command already exists in startup script." 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
    fi
else
    info er "Sorry, could not find the correct resolution of your monitor...\n  Exiting without setting up monitor resulation and refresh rate...\n" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
fi

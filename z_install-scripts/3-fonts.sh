#!/bin/bash

# log files
dir="$(dirname "$(realpath "$0")")"
parent_dir="$(dirname "$dir")"
log_dir="$parent_dir/Logs"
log="$log_dir/fonts_$(date +%d-%m-%y_).log"
mkdir -p "$log_dir" && touch "$log"

source "$dir/00-global.sh"

fonts=(
    ttf-font-awesome
    ttf-cascadia-code
    ttf-jetbrains-mono-nerd
    ttf-meslo-nerd
    noto-fonts 
    noto-fonts-emoji
)

# installing fonts
for font in "${fonts[@]}"; do
    install "$font" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
done
clear && sleep 1
#_________ end _________#
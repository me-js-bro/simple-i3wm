#!/bin/bash

scripts_dir=`dirname "$(realpath "$0")"`
source "$scripts_dir/00-global.sh"

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
    install "$font"
done

#_________ end _________#
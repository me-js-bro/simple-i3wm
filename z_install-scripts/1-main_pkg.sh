#!/bin/bash

# log files
dir="$(dirname "$(realpath "$0")")"
parent_dir="$(dirname "$dir")"
log_dir="$parent_dir/Logs"
log="$log_dir/main-packages_$(date +%d-%m-%y_).log"
mkdir -p "$log_dir" && touch "$log"

source "$dir/00-global.sh"

# main packages
packages=(
    dunst
    eog
    feh
    firefox
    i3-wm
    i3lock
    jq
    kitty
    maim
    neovim
    polybar
    polkit-gnome
    qt5ct
    qt5-svg
    qt5-graphicaleffects
    qt5-quickcontrols
    qt6ct
    qt6-svg
    ranger
    rofi
)

aur_packages=(
    nwg-look
    picom-simpleanims-git
)

# # thunar file manager
thunar=(
    ffmpegthumbnailer
    file-roller
    gvfs
    gvfs-mtp 
    thunar 
    thunar-volman 
    tumbler 
    thunar-archive-plugin
)

# install main packages
for pkgs in "${packages[@]}"; do
    install "$pkgs" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
done

clear

# install aur packages
for pkgs in "${aur_packages[@]}"; do
    install_Aur "$pkgs" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
done

clear

# install thunar
for pkgs in "${thunar[@]}"; do
    install "$pkgs" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
done
clear && sleep 1
#____________ end ____________#
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
    alacritty
    dunst
    eog
    feh
    firefox
    i3-wm
    i3lock
    jq
    maim
    neovim
    polybar
    polkit-gnome
    qt5ct
    qt6ct
    qt6-svg
    rofi
)

aur_packages=(
    nwg-look
    picom-simpleanims-git
    qt5-svg
    qt5-quickcontrols2
    qt5-graphicaleffects
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

# install aur packages
for pkgs in "${aur_packages[@]}"; do
    install_Aur "$pkgs" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
done

# install thunar
for pkgs in "${thunar[@]}"; do
    install "$pkgs" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
done
clear && sleep 1
#____________ end ____________#
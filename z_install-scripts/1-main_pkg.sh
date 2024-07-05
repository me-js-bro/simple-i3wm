#!/bin/bash

# install script dir
scripts_dir=`dirname "$(realpath "$0")"`
source $scripts_dir/00-global.sh

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
    install "$pkgs"
done

# install aur packages
for pkgs in "${aur_packages[@]}"; do
    install_Aur "$pkgs"
done

# install thunar
for pkgs in "${thunar[@]}"; do
    install "$pkgs"
done

#____________ end ____________#
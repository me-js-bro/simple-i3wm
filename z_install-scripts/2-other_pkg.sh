#!/bin/bash

scripts_dir=`dirname "$(realpath "$0")"`
source "$scripts_dir/00-global.sh"

other_packages=(
    btop
    brightnessctl
    curl
    fastfetch
    ffmpeg
    ibus
    imagemagick
    kvantum
    libinput
    lxappearance
    network-manager-applet
    networkmanager
    ntfs-3g
    nvtop
    os-prober
    pacman-contrib
    pamixer
    pavucontrol
    python-pywal
    wget
    xorg-xinput
    yad
)

# installing packages

for pkgs in "${other_packages[@]}"; do
    install "$pkgs"
done

#_________ end _________#
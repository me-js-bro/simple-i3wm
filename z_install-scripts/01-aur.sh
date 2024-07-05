#!/bin/bash

present_dir=`pwd`
scripts_dir=`dirname "$(realpath "$0")"`
source "$scripts_dir/00-global.sh"

clear

info qs "Which Aur helper would you like to install? \n  1) paru \n  2) yay\n"
read -p "  Select: " aur

if [[ "$aur" == "1" ]]; then
    info ac "Installing paru.."

    git clone --depth=1 "https://aur.archlinux.org/paru.git"
    cd paru
    makepkg -si --noconfirm
    sleep 1
    cd "$present_dir"
    sudo rm -rf paru

elif [[ "$aur" == "2" ]]; then
    info ac "Installing yay.."

    git clone --depth=1 "https://aur.archlinux.org/yay.git"
    cd yay
    makepkg -si --noconfirm
    sleep 1
    cd "$present_dir"
    sudo rm -rf yay
fi

if [[ -n "$aur_helper" ]]; then
    info ok "Aur Helper was installed successfully!"
else
    info er "Sorry, cound not install the aur helper. exitint the script here..." && sleep 1
    exit 1
fi
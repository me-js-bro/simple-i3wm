#!/bin/bash

# log files
dir="$(dirname "$(realpath "$0")")"
parent_dir="$(dirname "$dir")"
log_dir="$parent_dir/Logs"
log="$log_dir/aur-helper_$(date +%d-%m-%y_).log"
mkdir -p "$log_dir" && touch "$log"

source "$dir/00-global.sh"

clear

info qs "Which Aur helper would you like to install? \n  1) paru \n  2) yay\n"
read -p "  Select: " aur

if [[ "$aur" == "1" ]]; then
    info ac "Installing paru.."

    git clone --depth=1 "https://aur.archlinux.org/paru.git" 2>&1 | tee -a "$log"
    cd paru
    makepkg -si --noconfirm 2>&1 | tee -a "$log"
    sleep 1
    cd "$dir"
    sudo rm -rf paru

elif [[ "$aur" == "2" ]]; then
    info ac "Installing yay.."

    git clone --depth=1 "https://aur.archlinux.org/yay.git" 2>&1 | tee -a "$log"
    cd yay
    makepkg -si --noconfirm 2>&1 | tee -a "$log"
    sleep 1
    cd "$dir"
    sudo rm -rf yay
fi

if [[ -n "$aur_helper" ]]; then
    info ok "Aur Helper was installed successfully!" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
    sleep 1
    clear && sleep 1
else
    info er "Sorry, cound not install the aur helper. exiting the script here..." 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
    sleep 1

    exit 1
fi
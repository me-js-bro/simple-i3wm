#!/bin/bash

# log files
dir="$(dirname "$(realpath "$0")")"
parent_dir="$(dirname "$dir")"
log_dir="$parent_dir/Logs"
log="$log_dir/sddm_$(date +%d-%m-%y_).log"
mkdir -p "$log_dir" && touch "$log"

source "$dir/00-global.sh"

sddm_pkgs=(
    qt6-5compat 
    qt6-declarative 
    qt6-svg
    sddm
)

login_managers=(
    gdm 
    lightdm
    lxdm 
    lxdm-gtk3
)

# check if any login manager is installed...
for login_manager in "${login_managers[@]}"; do
    if sudo pacman -Qs "$login_manager" &> /dev/null; then
        info ac "Disabling $login_manager.."
        sudo systemctl disable "$login_manager" 2>&1 | tee -a "$log"
    fi
done

info at "Installing required packages.\n"
for sddm_pkg in "${sddm_pkgs[@]}"; do
    install "$sddm_pkg" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
    
done

sudo systemctl enable sddm.service 2>&1 | tee -a "$log" &> /dev/null

info at "Now setting up sddm theme.."

sddm_conf_dir=/etc/sddm.conf.d
[[ ! -d "$sddm_conf_dir" ]] && { info at "$sddm_conf_dir was not found, creating."; sudo mkdir -p "$sddm_conf_dir"; }

clear
    
# SDDM-themes
valid_input=false
while [ "$valid_input" != true ]; do
    info at "Installing SDDM Theme\n"
    mkdir -p "$parent_dir/.cache"


    git clone --depth=1 https://github.com/me-js-bro/sddm.git "$parent_dir/.cache/sddm"
    if [[ -d "$parent_dir/.cache/sddm" ]]; then
        # Check if /usr/share/sddm/themes/simple-sddm exists and remove if it does
        if [[ -d "/usr/share/sddm/themes/arch-sddm" ]]; then
        sudo rm -rf "/usr/share/sddm/themes/arch-sddm"
        info ok "Removed existing 'arch-sddm' directory.\n"
        fi

        # Check if simple-sddm directory exists in the current directory and remove if it does
        if [[ ! -d "/usr/share/sddm/themes" ]]; then
            sudo mkdir -p /usr/share/sddm/themes
            info ok "Directory '/usr/share/sddm/themes' created.\n"
        fi
      sudo cp -r "$parent_dir/.cache/sddm/arch-sddm" /usr/share/sddm/themes/
      printf "[Theme]\nCurrent=arch-sddm\n" | sudo tee "$sddm_conf_dir/theme.conf.user"
    fi
    valid_input=true
done

if [[ -d "/usr/share/sddm/themes/arch-sddm" ]]; then
    info ok "Sddm theme was installed successfully."
    rm -rf "$parent_dir/.cache/sddm"
fi

clear
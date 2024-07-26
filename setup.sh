#!/bin/bash

# color defination
red="\e[1;31m"
green="\e[1;32m"
yellow="\e[1;33m"
blue="\e[1;34m"
magenta="\e[1;1;35m"
cyan="\e[1;36m"
orange="\x1b[38;5;214m"
end="\e[1;0m"

# log files
dir="$(dirname "$(realpath "$0")")"
scripts="$dir/z_install-scripts"
log_dir="$dir/Logs"
log="$log_dir/Setup_$(date +%d-%m-%y).log"
mkdir -p "$log_dir" && touch "$log"

[[ -f "$scripts/00-global.sh" ]] && . "$scripts/00-global.sh" || { printf "${red}Could not file any 'Global Script, exiting now...'"; sleep 1; exit 1; }


text() {
    cat << "EOF"
  _  _____                                  _                             
 (_)|___ /__      __ _ __ ___    ___   ___ | |_  _   _  _ __              
 | |  |_ \\ \ /\ / /| '_ ` _ \  / __| / _ \| __|| | | || '_ \             
 | | ___) |\ V  V / | | | | | | \__ \|  __/| |_ | |_| || |_) |  _   _   _ 
 |_||____/  \_/\_/  |_| |_| |_| |___/ \___| \__| \__,_|| .__/  (_) (_) (_)
                                                       |_|                
EOF

}

clear
# printf "${orange}Starting${end}..\n" && text && sleep 1
info "${orange}Starting${end}..\n" && text && sleep 1

printf " \nBy...\n"

printf "${orange}           _        ${end}\n"
printf "${orange}  |  _    |_) __ _  ${end}\n"
printf "${orange}\_| _)    |_) | (_) ${end}\n"
sleep 2 && clear

info qs "Would you like to continue with the installation? [ y/n ]"
read -r -p "$(echo -e '\e[1;32m  Select: \e[1;0m')" ans

[[ "$ans" =~ ^[Yy]$ ]] && info ac "Starting the script here.."; sleep 1 || { info er "Exiting the script here.." ; exit 1; }

# make all the scripts executable
chmod +x "$scripts"/*
clear

# full system update
info ac "Updating the system"
sudo pacman -Syyu --noconfirm 2>&1 | tee -a "$log"

# Function to check for the presence of a battery
is_laptop() {
    if [[ -d "/sys/class/power_supply/BAT0" ]]; then
        echo "Laptop"
    fi
}
system_type=$(is_laptop)
if [[ "$system_type" == "Laptop" ]]; then
    info qs "You are using a laptop, right? [ y/n ]"
    read -r -p "$(echo -e '\e[1;32m  Select: \e[1;0m')" device
fi


#==========( starting scripts )==========#

aur_helper=$(command -v paru || command -v yay)
if [[ -n "$aur_helper" ]]; then
    info ok "Aur Helper was located in $aur_helper. Moving on.." 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
else
    "$scripts/01-aur.sh" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
fi


#==========( running scripts )==========#

"$scripts/1-main_pkg.sh" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
"$scripts/2-other_pkg.sh" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
"$scripts/3-fonts.sh" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
"$scripts/4-cliphist.sh" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
# "$scripts/5-monitor.sh" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")

if [[ "$device" =~ ^[Yy]$ ]]; then
    info ac "Starting script for touchpad setup"
    "$scripts/6-touchpad.sh" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
fi
info qs "Would you like to install and set sddm theme? [ y/n ]"
read -r -p "$(echo -e '\e[1;32mSelect: \e[1;0m')" sddm_man

[[ "$sddm_man" =~ ^[Yy]$ ]] && "$scripts/7-sddm.sh" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
clear && sleep 1


#==========( OpenBangla )==========#

info qs "Would you like to install ${orange}OpenBangla-Keyboard${end}?"
read -r -p "$(echo -e '\e[1;32m  Select: \e[1;0m')" keyboard

if [[ "$keyboard" =~ ^[Yy]$ ]]; then
    info ac "Installing ${orange}OpenBangla-Keyboard${end}"

    bash -c "$(wget -q https://raw.githubusercontent.com/me-js-bro/Build-OpenBangla-Keyboard/main/build.sh -O -)" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
fi

clear && sleep 1



#==========( config setup )==========#

chmod +x "$dir/config.sh"
"$dir/config.sh" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
clear

#==========( end )==========#

info ok "Script completes here... Now reboot your system to enjoy your i3 window manager." && sleep 1
info qs "Would you like to reboot now? [ y/n ]"
read -r -p "$(echo -e '\e[1;32m  Select: \e[1;0m')" reboot

if [[ "$reboot" =~ ^[Yy]$ ]]; then
    for time in 5 4 3 2 1; do
        info at "The system will reboot in ${time}s" && sleep 1 && clear
    done
        systemctl reboot --now
else
    info at "The system should be rebooted to make the changes...\n  However, make sure to reboot later..\n\n  Enjoy (◠‿◠)"
fi

exit 0
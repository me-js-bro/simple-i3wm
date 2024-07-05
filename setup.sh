#!/bin/bash

# log files
dir=`pwd`
scripts="$dir/z_install-scripts"
log_dir="$dir/Logs"
log="$log_dir/Main_$(date +%d-%m-%y).log"
mkdir -p "$log_dir" && touch "$log"

# color defination
red="\e[1;31m"
green="\e[1;32m"
yellow="\e[1;33m"
blue="\e[1;34m"
magenta="\e[1;1;35m"
cyan="\e[1;36m"
orange="\x1b[38;5;214m"
end="\e[1;0m"

# texts
att="${orange} [ ATTENTION ] ${end}"
acc="${green} [ ACTION ] ${end}"
ok="${cyan} [ OK ] ${end}"
note="${blue} [ NOTE ] ${end}"
qus="${yellow} [ QUESTION ] ${end}"
err="${red} [ ERROR ] ${end}"

# prompt message function
info() {
    local action="$1"
    local msg="$2"

    case $action in
        at) printf "$att \n  $msg\n" && sleep 1
        ;;
        ac) printf "$acc \n  $msg\n"
        ;;
        ok) printf "$ok \n  $msg\n" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
        ;;
        nt) printf "$note \n  $msg\n" && sleep 1
        ;;
        qs) printf "$qus \n  $msg\n"
        ;;
        er) printf "$err \n  $msg\n" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log") && sleep 1
        ;;
        *) echo "${yellow}$msg${end}"
        ;;
    esac
}

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
printf "${orange}Starting${end}..\n" && text && sleep 1

printf " \nBy...\n"

printf "${orange}          _        ${end}\n"
printf "${orange}  |  _    |_) __ _  ${end}\n"
printf "${orange}\_| _)    |_) | (_) ${end}\n"
sleep 2 && clear

info qs "Would you like to continue with the installation? [ y/n ]"
read -p "  Select: " ans

[[ "$ans" =~ ^[Yy]$ ]] && info ac "Starting the script here.." && sleep 1 || { info "Exiting the script here..." ; exit 1;}

# make all the scripts executable
chmod +x "$scripts"/*
clear

# running the main scripts
aur_helper=$(command -v paru || command -v yay)
if [[ -n "$aur_helper" ]]; then
    info ok "Aur Helper was located in $aur_helper. Moving on.."
else
    "$scripts/01-aur.sh"
fi


#==========( running scripts )==========#

"$scripts/1-main_pkg.sh"
"$scripts/2-other_pkg.sh"
"$scripts/3-fonts.sh"
clear && sleep 1



#==========( OpenBangla )==========#

info qs "Would you like to install ${orange}OpenBangla-Keyboard${end}?"
read -p "  Select: " keyboard

if [[ "$keyboard" =~ ^[Yy]$ ]]; then
    info ac "Installing ${orange}OpenBangla-Keyboard${end}"

    bash -c "$(wget -q https://raw.githubusercontent.com/me-js-bro/Build-OpenBangla-Keyboard/main/build.sh -O -)"
fi

clear && sleep 1



#==========( config setup )==========#

info at "Now setting up the configs"

dots=(
    alacritty
    dunst
    fastfetch
    gtk-3.0
    gtk-4.0
    i3
    nvim
    nwg-look
    polybar
    qt5ct
    qt6ct
    rofi
)

file=(
    picom.conf
)

# Loop through directories and files to back up
for dotfile in "${dots[@]}"; do
    config="$HOME/.config/$dotfile"
    if [[ -d "$config" ]]; then
        info at "$dotfile located in $config. Backing up..."
        mv "$config" "$config"-${USER}
    fi
done

for file in "${files[@]}"; do
    config="$HOME/.config/$file"
    if [[ -f "$config" ]]; then
        info at "$file located in $config. Backing up..."
        mv "$config" "$config"-${USER}
    fi
done

# copying the configs
info ac "Copying the dotfiles.."
cp -r "$dir/config"/* "$HOME/.config/"

if [[ -d "$HOME/.config/i3/scripts" ]]; then
    chmod +x "$HOME/.config/i3/scripts"/*
    info ok "Copied successfully!"
else
    info er "Could not copy dotfiles..."
    exit 1
fi

clear && sleep 1

#==========( theme setup )==========#

theme_dir="$dir/assets"
theme="$theme_dir/Nordic-darker.tar.xz"
icon="$theme_dir/Icon_TelaDracula.tar.gz"
cursor="$theme_dir/Nordic-darker.tar.xz"

# creating icons and theme directory
mkdir -p ~/.themes
mkdir -p ~/.icons

tar -xf "$theme" -C ~/.themes/
tar -xf "$icon" -C ~/.icons/
tar -xf "$cursor" -C ~/.icons/

if [[ -d "$HOME/.icons/Nordic-darker" ]]; then
    info ok "Icon and theme added successfully!"
fi

# setting default themes, icon and cursor
gsettings set org.gnome.desktop.interface gtk-theme "Nordic-darker"
gsettings set org.gnome.desktop.interface icon-theme "TokyoNight-SE"
gsettings set org.gnome.desktop.interface cursor-theme "Nordzy-cursors"


#==========( monitor setup )==========#

info at "Setting up your monitor.." && sleep 1
chmod +x "$dir/monitor.sh"
"$dir/monitor.sh"
clear


#==========( touchpad )==========#

# Function to check for the presence of a battery
is_laptop() {
    if [[ -d "/sys/class/power_supply/BAT0" ]]; then
        echo "Laptop"
    fi
}

# Determine if the system is a laptop or desktop
system_type=$(is_laptop)

if [[ "$system_type" == "Laptop" ]]; then
    info qs "You are using a laptop, right? [ y/n ]"
    read -p "  Select: " device
    
    printf " \n"

    if [[ "$device" =~ ^[Yy]$ ]]; then
        info ac "Starting script for touchpad"
        chmod +x "$dir/touchpad.sh"
        "$dir/touchpad.sh"
    fi
fi
sleep 1

#==========( end )==========#

info ok "Script completes here... Now logout and login to your new i3 window manager." && sleep 1

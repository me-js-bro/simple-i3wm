# log files
dir="$(dirname "$(realpath "$0")")"
scripts="$dir/z_install-scripts"
log_dir="$dir/Logs"
log="$log_dir/Config_$(date +%d-%m-%y).log"
mkdir -p "$log_dir" && touch "$log"

source "$scripts/00-global.sh"

info at "Now setting up the configs" && sleep 1

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
        mv "$config" "$config-${USER}_$(date +%I-%M-%p)" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
    fi
done

for file in "${files[@]}"; do
    config="$HOME/.config/$file"
    if [[ -f "$config" ]]; then
        info at "$file located in $config. Backing up..."
        mv "$config" "$config-${USER}_$(date +%I-%M-%p)" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
    fi
done

# copying the configs
info ac "Copying the dotfiles.."
cp -r "$dir/config"/* "$HOME/.config/"

if [[ -d "$HOME/.config/i3/scripts" ]]; then
    chmod +x "$HOME/.config/i3/scripts"/*
    info ok "Copied successfully!" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
    exit 0
else
    info er "Could not copy dotfiles..." 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
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

tar -xf "$theme" -C ~/.themes/ 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
tar -xf "$icon" -C ~/.icons/ 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
tar -xf "$cursor" -C ~/.icons/ 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")

if [[ -d "$HOME/.icons/Nordic-darker" ]]; then
    info ok "Icon and theme added successfully!" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
fi

# setting default themes, icon and cursor
gsettings set org.gnome.desktop.interface gtk-theme "Nordic-darker"
gsettings set org.gnome.desktop.interface icon-theme "Tela-circle-dracula"
gsettings set org.gnome.desktop.interface cursor-theme "Nordzy-cursors"
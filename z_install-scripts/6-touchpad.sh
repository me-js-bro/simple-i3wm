#!/bin/bash

# log files
dir="$(dirname "$(realpath "$0")")"
parent_dir="$(dirname "$dir")"
log_dir="$parent_dir/Logs"
log="$log_dir/touchpad_$(date +%d-%m-%y_).log"
mkdir -p "$log_dir" && touch "$log"

source "$dir/00-global.sh"


# Create the configuration directory if it doesn't exist
info at "Creating configuration directory"
sudo mkdir -p /etc/X11/xorg.conf.d 2>&1 | tee -a "$log"

# Create the 40-libinput.conf file
config_file="/etc/X11/xorg.conf.d/40-libinput.conf"

info at "Creating touchpad configuration file"

sudo tee $config_file > /dev/null <<EOL
Section "InputClass"
    Identifier "libinput touchpad catchall"
    MatchIsTouchpad "on"
    MatchDevicePath "/dev/input/event*"
    Driver "libinput"
    Option "Tapping" "on"                 # Enable tapping
    Option "NaturalScrolling" "true"      # Enable natural scrolling
    Option "ScrollMethod" "twofinger"     # Two-finger scrolling
    Option "DisableWhileTyping" "true"    # Disable while typing
EndSection
EOL

# Provide feedback to the user
if [ $? -eq 0 ]; then
    info ok "Touchpad configuration file created successfully!" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
else
    info er "Failed to create touchpad configuration file" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
    exit 1
fi

# Get the touchpad ID
touchpad_id=$(xinput list | grep -i touchpad | awk '{print $6}' | cut -d'=' -f2)

if [ -z "$touchpad_id" ]; then
    info at "No touchpad found. Exiting." 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
    exit 1
fi

# Add xinput commands to i3 startup file if they don't already exist
startup_file="$HOME/.config/i3/config"
info ac "Adding xinput commands to i3 startup file"
grep -qxF 'exec --no-startup-id xinput set-prop <your_touchpad_id> "libinput Tapping Enabled" 1' "$startup_file" || echo 'exec --no-startup-id xinput set-prop <your_touchpad_id> "libinput Tapping Enabled" 1' >> "$startup_file"
grep -qxF 'exec --no-startup-id xinput set-prop <your_touchpad_id> "libinput Natural Scrolling Enabled" 1' "$startup_file" || echo 'exec --no-startup-id xinput set-prop <your_touchpad_id> "libinput Natural Scrolling Enabled" 1' >> "$startup_file"


# Provide feedback to the user
if [ $? -eq 0 ]; then
    info ok "xinput commands added to i3 startup file successfully!" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
else
    info er "Failed to add xinput commands to i3 startup file." 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
    exit 1
fi
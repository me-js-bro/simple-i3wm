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

# Create the configuration directory if it doesn't exist
info at "Creating configuration directory"
sudo mkdir -p /etc/X11/xorg.conf.d

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
    info ok "Touchpad configuration file created successfully!"
else
    info er "Failed to create touchpad configuration file"
    exit 1
fi

# Get the touchpad ID
touchpad_id=$(xinput list | grep -i touchpad | awk '{print $6}' | cut -d'=' -f2)

if [ -z "$touchpad_id" ]; then
    info at "No touchpad found. Exiting."
    exit 1
fi

# Add xinput commands to i3 startup file if they don't already exist
startup_file="$HOME/.config/i3/config"
info ac "Adding xinput commands to i3 startup file"
grep -qxF 'exec --no-startup-id xinput set-prop <your_touchpad_id> "libinput Tapping Enabled" 1' "$startup_file" || echo 'exec --no-startup-id xinput set-prop <your_touchpad_id> "libinput Tapping Enabled" 1' >> "$startup_file"
grep -qxF 'exec --no-startup-id xinput set-prop <your_touchpad_id> "libinput Natural Scrolling Enabled" 1' "$startup_file" || echo 'exec --no-startup-id xinput set-prop <your_touchpad_id> "libinput Natural Scrolling Enabled" 1' >> "$startup_file"


# Provide feedback to the user
if [ $? -eq 0 ]; then
    info ok "xinput commands added to i3 startup file successfully!"
else
    info er "Failed to add xinput commands to i3 startup file."
    exit 1
fi
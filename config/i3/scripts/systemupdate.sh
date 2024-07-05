#!/usr/bin/env bash

# Check for updates
aurhlpr=$(command -v yay || command -v paru)
aur=$(${aurhlpr} -Qua | wc -l)

# Check for flatpak updates
ofc=$(checkupdates | wc -l)

# Calculate total available updates
upd=$(( ofc + aur ))

# Show tooltip
if [[ "$upd" == 0 ]] ; then
    echo "$upd"
    # notify "  Packages are up to date"
else
    echo "$upd"
    notify-send "󱓽 Updates Available: $upd"
fi

update_packages() {
    alacritty --title systemupdate -e sh -c "${aurhlpr} -Syu --noconfirm"
}

# Trigger upgrade
if [ "$1" == "up" ] ; then
    update_packages
    sleep 1

    if [[ "$upd" -eq 0 ]] ; then
        notify-send "  Packages updated successfully"
    elif [[ "$upd" -gt 0 ]]; then
        notify-send "Could not update your packages."
    fi
fi

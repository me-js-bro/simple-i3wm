#!/bin/bash

wall="$HOME/.config/i3/.cache/current.png"

if [[ -f "$wall" ]]; then
    wal -i "$wall"
fi

# Extract colors from colors.json
colors_file=~/.cache/wal/colors.json
colors_conf=~/.config/i3/configs/colors.conf

# Function to update i3 colors
update_i3_colors() {
    # Extract colors using jq
    background_color=$(jq -r '.special.background' "$colors_file")
    foreground_color=$(jq -r '.special.foreground' "$colors_file")
    color0=$(jq -r '.colors.color0' "$colors_file")
    color1=$(jq -r '.colors.color1' "$colors_file")
    color2=$(jq -r '.colors.color2' "$colors_file")
    color3=$(jq -r '.colors.color3' "$colors_file")
    color4=$(jq -r '.colors.color4' "$colors_file")
    color5=$(jq -r '.colors.color5' "$colors_file")
    color6=$(jq -r '.colors.color6' "$colors_file")
    color7=$(jq -r '.colors.color7' "$colors_file")

    # Ensure the colors.conf file exists before trying to update it
    if [ -f "$colors_conf" ]; then
        sed -i "s/\(client.focused\s\+\)#[0-9A-Fa-f]\{6\}\s\+#[0-9A-Fa-f]\{6\}\s\+#[0-9A-Fa-f]\{6\}\s\+#[0-9A-Fa-f]\{6\}\s\+#[0-9A-Fa-f]\{6\}/\1$color0 $color1 $color2 $color3  $color4/" "$colors_conf"
        sed -i "s/\(client.focused_inactive\s\+\)#[0-9A-Fa-f]\{6\}\s\+#[0-9A-Fa-f]\{6\}\s\+#[0-9A-Fa-f]\{6\}\s\+#[0-9A-Fa-f]\{6\}\s\+#[0-9A-Fa-f]\{6\}/\1$color2 $color3 $color0 $color5  $color3/" "$colors_conf"
        sed -i "s/\(client.unfocused\s\+\)#[0-9A-Fa-f]\{6\}\s\+#[0-9A-Fa-f]\{6\}\s\+#[0-9A-Fa-f]\{6\}\s\+#[0-9A-Fa-f]\{6\}\s\+#[0-9A-Fa-f]\{6\}/\1$color2 $color0 $color7 $color3  $color3/" "$colors_conf"
        sed -i "s/\(client.urgent\s\+\)#[0-9A-Fa-f]\{6\}\s\+#[0-9A-Fa-f]\{6\}\s\+#[0-9A-Fa-f]\{6\}\s\+#[0-9A-Fa-f]\{6\}\s\+#[0-9A-Fa-f]\{6\}/\1$color4 $color5 $color0 $color0  $color5/" "$colors_conf"
        sed -i "s/\(client.placeholder\s\+\)#[0-9A-Fa-f]\{6\}\s\+#[0-9A-Fa-f]\{6\}\s\+#[0-9A-Fa-f]\{6\}\s\+#[0-9A-Fa-f]\{6\}\s\+#[0-9A-Fa-f]\{6\}/\1$color6 $color6 $color0 $color6  $color6/" "$colors_conf"
        sed -i "s/\(client.background\s\+\)#[0-9A-Fa-f]\{6\}\s\+#[0-9A-Fa-f]\{6\}\s\+#[0-9A-Fa-f]\{6\}\s\+#[0-9A-Fa-f]\{6\}\s\+#[0-9A-Fa-f]\{6\}/\1$color0/" "$colors_conf"
    else
        echo "File $colors_conf does not exist."
    fi
}

update_i3_colors


# ----- Polybar

# Path to colors-polybar file
polybar_config="$HOME/.config/polybar/colors.ini"

# Function to update Polybar colors
update_polybar_colors() {
    # Extract colors using jq
    background=$(jq -r '.special.background' "$colors_file")
    background_alt=$(jq -r '.colors.color1' "$colors_file")
    foreground=$(jq -r '.special.foreground' "$colors_file")
    foreground_alt=$(jq -r '.colors.color3' "$colors_file")
    primary=$(jq -r '.colors.color4' "$colors_file")
    secondary=$(jq -r '.colors.color5' "$colors_file")
    alert=$(jq -r '.colors.color6' "$colors_file")
    disabled=$(jq -r '.colors.color7' "$colors_file")

    clr1=$(jq -r '.colors.color8' "$colors_file")
    clr2=$(jq -r '.colors.color9' "$colors_file")
    clr3=$(jq -r '.colors.color12' "$colors_file")
    clr4=$(jq -r '.colors.color13' "$colors_file")

    # Update Polybar configuration
    sed -i "s/^background = .*/background = $background/g" "$polybar_config"
    sed -i "s/^background-alt = .*/background-alt = $background_alt/g" "$polybar_config"
    sed -i "s/^foreground = .*/foreground = $foreground/g" "$polybar_config"
    sed -i "s/^foreground-alt = .*/foreground-alt = $foreground_alt/g" "$polybar_config"
    sed -i "s/^primary = .*/primary = $primary/g" "$polybar_config"
    sed -i "s/^secondary = .*/secondary = $secondary/g" "$polybar_config"
    sed -i "s/^alert = .*/alert = $alert/g" "$polybar_config"
    sed -i "s/^disabled = .*/disabled = $disabled/g" "$polybar_config"
    sed -i "s/^clr1 = .*/clr1 = $clr1/g" "$polybar_config"
    sed -i "s/^clr2 = .*/clr2 = $clr2/g" "$polybar_config"
    sed -i "s/^clr3 = .*/clr3 = $clr3/g" "$polybar_config"
    sed -i "s/^clr4 = .*/clr4 = $clr4/g" "$polybar_config"
}

update_polybar_colors



# alacritty colors
alacritty=~/.config/alacritty/alacritty.toml

# Extract colors using jq
background_color=$(jq -r '.special.background' "$colors_file")
foreground_color=$(jq -r '.special.foreground' "$colors_file")

# Normal colors
black=$(jq -r '.colors.color0' $colors_file)
red=$(jq -r '.colors.color1' $colors_file)
green=$(jq -r '.colors.color2' $colors_file)
yellow=$(jq -r '.colors.color3' $colors_file)
blue=$(jq -r '.colors.color4' $colors_file)
magenta=$(jq -r '.colors.color5' $colors_file)
cyan=$(jq -r '.colors.color6' $colors_file)
white=$(jq -r '.colors.color7' $colors_file)

# Bright colors
bright_black=$(jq -r '.colors.color8' $colors_file)
bright_red=$(jq -r '.colors.color9' $colors_file)
bright_green=$(jq -r '.colors.color10' $colors_file)
bright_yellow=$(jq -r '.colors.color11' $colors_file)
bright_blue=$(jq -r '.colors.color12' $colors_file)
bright_magenta=$(jq -r '.colors.color13' $colors_file)
bright_cyan=$(jq -r '.colors.color14' $colors_file)
bright_white=$(jq -r '.colors.color15' $colors_file)

# Update Alacritty configuration file with new colors
sed -i "s/^background = .*/background = \"$background_color\"/g" "$alacritty"
sed -i "s/^foreground = .*/foreground = \"$foreground_color\"/g" "$alacritty"

sed -i "s/^black = .*/black = \"$black\"/g" "$alacritty"
sed -i "s/^red = .*/red = \"$red\"/g" "$alacritty"
sed -i "s/^green = .*/green = \"$green\"/g" "$alacritty"
sed -i "s/^yellow = .*/yellow = \"$yellow\"/g" "$alacritty"
sed -i "s/^blue = .*/blue = \"$blue\"/g" "$alacritty"
sed -i "s/^magenta = .*/magenta = \"$magenta\"/g" "$alacritty"
sed -i "s/^cyan = .*/cyan = \"$cyan\"/g" "$alacritty"
sed -i "s/^white = .*/white = \"$white\"/g" "$alacritty"

sed -i "s/^bright_black = .*/bright_black = \"$bright_black\"/g" "$alacritty"
sed -i "s/^bright_red = .*/bright_red = \"$bright_red\"/g" "$alacritty"
sed -i "s/^bright_green = .*/bright_green = \"$bright_green\"/g" "$alacritty"
sed -i "s/^bright_yellow = .*/bright_yellow = \"$bright_yellow\"/g" "$alacritty"
sed -i "s/^bright_blue = .*/bright_blue = \"$bright_blue\"/g" "$alacritty"
sed -i "s/^bright_magenta = .*/bright_magenta = \"$bright_magenta\"/g" "$alacritty"
sed -i "s/^bright_cyan = .*/bright_cyan = \"$bright_cyan\"/g" "$alacritty"
sed -i "s/^bright_white = .*/bright_white = \"$bright_white\"/g" "$alacritty"

# (__________________________)

# setting rofi theme
ln -sf ~/.cache/wal/colors-rofi-dark.rasi ~/.config/rofi/themes/rofi-pywal.rasi

# remove these part if you don't like the colors according to your wallpaper.
if [ -f $colors_file ]; then
    background_color=$(jq -r '.special.background' "$colors_file")
    foreground_color=$(jq -r '.special.foreground' "$colors_file")

    # Update VS Code settings
    vscode_settings_file="$HOME/.config/Code/User/settings.json"
    cat <<EOF >"$vscode_settings_file"
{
    "editor.mouseWheelZoom": true,
    "workbench.startupEditor": "none",
    "editor.fontSize": 20,
    "editor.fontFamily": "'JetBrainsMono Nerd Font', 'Droid Sans Mono', 'monospace', monospace",
    "editor.fontLigatures": true,
    "window.menuBarVisibility": "toggle",
    "editor.smoothScrolling": true,
    "editor.scrollbar.horizontal": "hidden",
    "editor.mouseWheelScrollSensitivity": 2,
    "editor.wordWrap": "on",
    "editor.cursorBlinking": "expand",
    "terminal.integrated.fontSize": 18,
    "workbench.iconTheme": "catppuccin-mocha",
    "workbench.colorTheme": "Theme Darker",
    "git.enableSmartCommit": true,
    "files.autoSave": "afterDelay",
    // You can remove these part if you don't like the colors according to your wallpaper from the "$HOME/.config/hypr/scripts/pywal.sh" script, from 204-221 lines.
    // or you can totally remove the vs-code themming part from the script if you want to set and use your custom settings. if you don't do that, then your settings will be replaced/over writen by the default config.

    "workbench.colorCustomizations": {
        "editor.background": "$background_color",
        "sideBar.background": "$background_color",
        "sideBar.border": "$background_color",
        "sideBar.foreground": "$foreground_color",
        "editorGroupHeader.tabsBackground": "#191b274b",
        "activityBar.background": "$background_color",
        "activityBar.border": "$background_color",
        "activityBar.foreground": "$foreground_color",
        "tab.activeBackground": "#13151f",
        "tab.activeForeground": "#ffffff",
        "tab.activeBorder": "$background_color",
        "tab.border": "$background_color",
        "tab.inactiveBackground": "$background_color",
        "tab.inactiveForeground": "$foreground_color",
        "terminal.foreground": "$foreground_color",
        "terminal.background": "$background_color"
    },
}
EOF
fi


# ----- Dunst
dunst_file="$HOME/.config/dunst/dunstrc"

# Function to update Dunst colors
update_dunst_colors() {
    frame=$(jq -r '.colors.color4' "$colors_file")
    low_bg=$(jq -r '.colors.color0' "$colors_file")
    low_fg=$(jq -r '.colors.color7' "$colors_file")
    normal_bg=$(jq -r '.special.background' "$colors_file")
    normal_fg=$(jq -r '.special.foreground' "$colors_file")
    critical_bg=$(jq -r '.colors.color1' "$colors_file")
    critical_fg=$(jq -r '.colors.color7' "$colors_file")
    critical_frame=$(jq -r '.colors.color1' "$colors_file")

    echo "$normal_bg"
    echo "$normal_fg"

    # Update Dunst configuration
    sed -i "s/frame_color = .*/frame_color = \"$frame\"/g" "$dunst_file"
    sed -i "/^\[urgency_low\]/,/^\[/ s/^    background = .*/    background = \"$low_bg\"/g" "$dunst_file"
    sed -i "/^\[urgency_low\]/,/^\[/ s/^    foreground = .*/    foreground = \"$low_fg\"/g" "$dunst_file"
    sed -i "/^\[urgency_normal\]/,/^\[/ s/^    background = .*/    background = \"${normal_bg}80\"/g" "$dunst_file"
    sed -i "/^\[urgency_normal\]/,/^\[/ s/^    foreground = .*/    foreground = \"$normal_fg\"/g" "$dunst_file"
    sed -i "/^\[urgency_critical\]/,/^\[/ s/^    background = .*/    background = \"$critical_bg\"/g" "$dunst_file"
    sed -i "/^\[urgency_critical\]/,/^\[/ s/^    foreground = .*/    foreground = \"$critical_fg\"/g" "$dunst_file"
    sed -i "/^\[urgency_critical\]/,/^\[/ s/^    frame_color = .*/    frame_color = \"$critical_frame\"/g" "$dunst_file"
}

update_dunst_colors


# ------------------------

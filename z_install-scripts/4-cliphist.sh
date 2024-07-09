#!/bin/bash

# log files
dir="$(dirname "$(realpath "$0")")"
parent_dir="$(dirname "$dir")"
log_dir="$parent_dir/Logs"
log="$log_dir/clipboard_$(date +%d-%m-%y_).log"
mkdir -p "$log_dir" && touch "$log"

source "$dir/00-global.sh"

pkgs=(
    rofi-greenclip
)

for pkg in "${pkgs[@]}"; do
    install_Aur "$pkg" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
done

# Create Greenclip configuration
mkdir -p ~/.config
cat << EOF > ~/.config/greenclip.toml
[greenclip]
  history_file = "~/.cache/greenclip.history"
  max_history_length = 50
  max_selection_size_bytes = 0
  trim_space_from_selection = true
  use_primary_selection_as_input = false
  blacklisted_applications = []
  enable_image_support = true
  image_cache_directory = "/tmp/greenclip"
  static_history = [
  ]
EOF

# Create systemd service for Greenclip
mkdir -p ~/.config/systemd/user/
cat << EOF > ~/.config/systemd/user/greenclip.service
[Unit]
Description=Greenclip daemon

[Service]
ExecStart=/usr/bin/greenclip daemon
Restart=always

[Install]
WantedBy=default.target
EOF

# Reload systemd user units and start Greenclip service
systemctl --user daemon-reload 2>&1 | tee -a "$log"
systemctl --user enable greenclip.service 2>&1 | tee -a "$log"
systemctl --user start greenclip.service 2>&1 | tee -a "$log"

info ok "Greenclip and Rofi clipboard manager setup complete!" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log")
clear && sleep 1
#!/bin/bash

scripts_dir=`dirname "$(realpath "$0")"`
source "$scripts_dir/00-global.sh"

pkgs=(
    rofi-greenclip
)

for pkg in "${pkgs[@]}"; do
    install_Aur "$pkg"
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
systemctl --user daemon-reload
systemctl --user enable greenclip.service
systemctl --user start greenclip.service

info ok "Greenclip and Rofi clipboard manager setup complete!"

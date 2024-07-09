#!/bin/bash

# it has a little bug.........

i3_dir="$HOME/.config/i3"
scripts_dir="$i3_dir/scripts"
cache_dir="$i3_dir/.cache"
theme_file="$cache_dir/theme"

if [[ -f "$theme_file" ]]; then
    source "$theme_file"
fi

wallpaper_dir="$i3_dir/wallpapers/$current"

pics=($(find ${wallpaper_dir} -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \)))
random_pic=${pics[ $RANDOM % ${#pics[@]} ]}
RANDOM_PIC_NAME="${#random_pic[@]}. random"

# Rofi command ( style )
case $1 in
  style1)
      rofi_command="rofi -show -dmenu -config ~/.config/rofi/themes/conf-wall.rasi"
      ;;
  style2)
      rofi_command="rofi -show -dmenu -config ~/.config/rofi/themes/conf-wall-2.rasi"
      ;;
esac

menu() {
  for i in "${!pics[@]}"; do
    # Displaying .gif to indicate animated images
    if [[ -z $(echo "${pics[$i]}" | grep .gif$) ]]; then
      printf "$(echo "${pics[$i]}" | cut -d. -f1)\x00icon\x1f${wallDIR}/${pics[$i]}\n"
    else
      printf "${pics[$i]}\n"
    fi
  done

  printf "$RANDOM_PIC_NAME\n"
}

main() {
    choice=$(menu | ${rofi_command})

    # No choice case
    if [[ -z $choice ]]; then
      exit 0
    fi

    # Random choice case
    if [ "$choice" = "$RANDOM_PIC_NAME" ]; then
      feh --bg-scale "${wallDIR}/${random_pic}"
      exit 0
    fi


    if [[ $pic_index -ne -1 ]]; then
      notify-send -i "${wallDIR}/${pics[$pic_index]}" "Changing wallpaper"
      feh --bg-scale "${wallDIR}/${pics[$pic_index]}"
    else
      echo "Image not found."
      exit 1
    fi
  }

# Check if rofi is already running
if pidof rofi > /dev/null; then
  pkill rofi
  exit 0
fi

main

sleep 0.5
"$scripts_dir/pywal.sh"
sleep 0.2
"$scripts_dir/Refresh.sh"



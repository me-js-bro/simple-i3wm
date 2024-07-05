#!/bin/bash

pic_dir="$HOME/Pictures"
save_dir="$pic_dir/Screenshots"
save_file="$(date +%s).png"

mkdir -p "$save_dir"

send_notification() {
    local msg="$1"
    notify-send "Taking Screenshot in" "$msg"
    sleep 1
    pkill dunst
}

case "$1" in
    "--full")
        for i in 3 2 1; do
            send_notification "$i"
        done
        sleep 1
        maim "$save_dir/$save_file"
        ;;
    "--select")
        maim -s "$save_dir/$save_file"
        ;;
    "--crop")
        maim -u | feh -F - &
        maim -s -k "$save_dir/$save_file"
        kill $!
        ;;
    *)
        echo "Usage: $0 {--full|--select|--crop}"
        exit 1
        ;;
esac

if [ -f "$save_dir/$save_file" ]; then
    notify-send "Saved in $save_dir" -i "$save_dir/$save_file"
fi

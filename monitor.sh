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

monitor=($(xrandr -q | grep " connected" | cut -d ' ' -f1))

X=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f1)
Y=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f2)

res=${X}x${Y}
printf "${yellow}Is your monitor resolution${orange} ${res}p${end}? [ y/n ]\n"
read -r -p "$(echo -e '\e[1;32mSelect: \e[1;0m')" size

printf "\n${yellow}What is your monitor supported refresh rate? ${orange}\n1) 60Hz \n2) 75Hz \n3) 144Hz${end}\n"
read -p "$(echo -e '\e[1;32mSelect: \e[1;0m')" refresh
case $refresh in
	1) hz="60"
	    ;;
	2) hz="75"
	    ;;
	3) hz="144"
	    ;;
	*) printf "${red}Select from 1/2/3${end}\n"
	    ;;
esac

if [[ "$size" =~ ^[Yy]$ ]]; then
    printf "\n${yellow}Setting your monitor resolution and refresh rate to ${res}p ${hz}Hz ${end}\n"
    sleep 2
    xrandr --output $monitor --mode $res --rate $hz

    startup="$HOME/.config/i3/scripts/startup.sh"
    if ! grep -q "xrandr --output $monitor --mode $res --rate $hz" "$startup"; then
        echo -e "\n\nxrandr --output $monitor --mode $res --rate $hz" >> "$startup"
        printf "${green}Monitor setup command added to startup script.${end}\n"
    else
        printf "${blue}Monitor setup command already exists in startup script.${end}\n"
    fi
fi

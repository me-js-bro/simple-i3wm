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
        at) printf "$att \n  $msg\n"
        ;;
        ac) printf "$acc \n  $msg\n"
        ;;
        ok) printf "$ok \n  $msg\n\n"
        ;;
        nt) printf "$note \n  $msg\n"
        ;;
        qs) printf "$qus \n  $msg\n"
        ;;
        er) printf "\n$err \n  ${red}$msg${end}\n"
        ;;
        *) echo "$msg"
        ;;
    esac
}

# Define installation functions
package_manager=$(command -v pacman || command -v yay || command -v paru)
aur_helper=$(command -v yay || command -v paru) # Find the AUR helper

# Check if the package is installed
check() {
    local is_installed
    is_installed=$(sudo "$package_manager" -Qs "$1" &> /dev/null; echo $?)
    
    if [ "$is_installed" -eq 0 ]; then
        case $2 in
            1) info ok "$1 is already installed"; return 0 ;;
            2) return 0 ;;
        esac
    else
        case $2 in
            2) info er "Could not install $1"; return 1 ;;
        esac
        return 1
    fi
}

# Install using package manager
install() {
    if check "$1" 1; then
        return 0
    else
        info ac "Installing $1" && sleep 0.5
        sudo pacman -S --noconfirm "$1" && check "$1" 2 && info ok "$1 was installed successfully"
    fi
}

# install using aur
install_Aur() {
    if check "$1" 1; then
        return 0
    else
        info ac "Installing $1" && sleep 0.5
        "$aur_helper" -S --noconfirm "$1" && check "$1" 2 && info ok "$1 was installed successfully"
    fi
}
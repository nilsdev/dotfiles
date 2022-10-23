#!/usr/bin/bash

Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# ┌──────────────────────────────────────────────┐
# │ check for yay and install if it doesnt exist │
# └──────────────────────────────────────────────┘

echo    "┌─────────────────────────────────┐"
echo    "│ checking for packages           │"
echo -e "│ ${Green}Installed${Color_Off}                       │"
echo -e "│ ${Red}Not Installed${Color_Off}                   │"
echo    "└─────────────────────────────────┘"
if pacman -Q "yay" > /dev/null 2>&1; then 
	echo -e "${Green}yay${Color_Off}" 
else
 	sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git ~/yay && cd ~/yay && makepkg -si -y 
fi

# ┌───────────────────┐
# │ required packages │
# └───────────────────┘

packages=(
	neovim
	htop
	fzf
	zsh
	firefox
	kitty
	hyprland-bin
	python
	ranger
	wl-clipboard
	#lxappearance
	lxappearance-gtk3
	pavucontrol
	sxhkd
    brightnessctl
    rofi 
)

# ┌────────────────────────────┐
# │ check and install packages │
# └────────────────────────────┘

for package in ${packages[@]}; do 
	if pacman -Q "$package" > /dev/null 2>&1; then 
		# echo -e "$package \t-> is installed" 
		echo -e "${Green}${package}${Color_Off}" 
	else 
		echo -e "${Red}${package}${Color_Off}" 
		yay -S "$package" --noconfirm
	fi
done

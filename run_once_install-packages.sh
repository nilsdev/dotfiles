#!/usr/bin/bash

packages=(
	neovim
	htop
	fzf
	zsh
	firefox
	kitty
	hyprland
	python
)

if pacman -Q "yay" > /dev/null 2>&1; then 
	echo -e "yay \t-> is installed" 
else
	pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git ~/yay && cd ~/yay && makepkg -si
fi



for package in ${packages[@]}; do 
	if pacman -Q "$package" > /dev/null 2>&1; then 
		echo -e "$package \t-> is installed" 
	else 
		echo -e "$package \t-> has to be installed"
		echo -e "start installing $package"
		yay -S "$package" --noconfirm
		echo -e "end installing $package"
	fi
done

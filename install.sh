#!/bin/bash

ARCH=/usr/bin/pacman
DEB=/usr/bin/apt
if [ -f "$ARCH" ]; then
    sudo pacman -S git curl ripgrep deno
elif [ -f "$DEB" ]; then
    sudo apt install git curl ripgrep
	curl -fsSL https://deno.land/x/install/install.sh | sh
else
	echo "Please install this before launching nvim :"
	echo "git ripgrep deno"
fi

FILE=~/.config/nvim/
if [ -f "$FILE" ]; then
	mkdir ~/.config/nvim/undodir/
else
	mkdir ~/.config/nvim
	mkdir ~/.config/nvim/undodir/
fi

cp init.lua ~/.config/nvim/

echo "LynxVim is (almost) installed"
echo "Launch nvim to install the plugins and you are ready to go !"

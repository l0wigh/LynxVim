#!/bin/bash

FILE=/usr/bin/pacman
if [ -f "$FILE" ]; then
    sudo pacman -S git curl ripgrep deno
else
    sudo apt install git curl ripgrep deno
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

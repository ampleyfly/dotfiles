#!/usr/bin/env bash

set -e

if [ "$1" = "-f" ]; then
	force=true
fi

link() {
	name="$HOME/$1/$(basename $2)"
	target="$HOME/.dotfiles/$2"
	mkdir -pv "$HOME/$1"
	if [ "$force" = true -a -h "$name" ]; then
		rm -v "$name"
	fi
	if [ ! -h "$name" ]; then
		ln -sv "$target" "$name"
	fi
}

git submodule update --init --recursive

link . .gitconfig
link . .i3
link . .vimrc
link . .Xresources
link .vim/bundle submodules/vim-pathogen
link .vim/bundle submodules/solarized/vim-colors-solarized
link .vim/bundle submodules/vim-fugitive
link .vim/bundle submodules/vim-surround
link .urxvt/ext submodules/urxvt-perls/url-select

xrdb -merge "$HOME"/.Xresources

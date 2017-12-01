#!/bin/sh

mkdir -p $HOME/.vim
mkdir -p $HOME/.vim/undo
mkdir -p $HOME/.vim/tags
if [ ! -f "$HOME/.vim/autoload/plug.vim" ];then
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
curl -o $HOME/.vimrc https://raw.githubusercontent.com/chendagui16/ConfigFile/master/vimrc

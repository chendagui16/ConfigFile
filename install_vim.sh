#!/bin/sh

# [[ ! -d "$HOME/.vim" ]] && mkdir $HOME/.vim
[[ ! -d "$HOME/.vim" ]] && mkdir $HOME/.vim
[[ ! -d "$HOME/.vim/undo" ]] && mkdir $HOME/.vim/undo
[[ ! -d "$HOME/.vim/tags" ]] && mkdir $HOME/.vim/tags
if [ ! -f "$HOME/.vim/autoload/plug.vim" ];then
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
curl -o $HOME/.vimrc https://raw.githubusercontent.com/chendagui16/ConfigFile/master/vimrc

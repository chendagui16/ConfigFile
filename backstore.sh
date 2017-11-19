#!/bin/sh

DIR=`pwd`
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++ 1. Store ConfigFile  +++++++++++++++"
echo "++++++++++++++  2. Restore ConfigFile ++++++++++++++"
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++"
read -p "Input the choice:" choice
if [ $choice -eq 1 ];then
	echo Store ConfigFile $DIR from $HOME ...
	cp $HOME/.vimrc $DIR/vimrc
	cp $HOME/.tmux.conf $DIR/tmux.conf
	cp $HOME/.zshrc $DIR/zshrc
	cp $HOME/.config/flake8 $DIR/flake8
	mkdir -p $DIR/.vim
	cp -r $HOME/.vim/UltiSnips $DIR/.vim
	cp -r $HOME/.vim/ftplugin $DIR/.vim
fi
if [ $choice -eq 2 ];then
	mkdir -p $HOME/.vim
	mkdir -p $HOME/.vim/undo
	mkdir -p $HOME/.vim/tags
	mkdir -p $HOME/.config
	if [ ! -f "$HOME/.vim/autoload/plug.vim" ];then
		curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	fi
	echo Restore ConfigFile from $DIR ...
	cp $DIR/vimrc $HOME/.vimrc
	cp $DIR/tmux.conf $HOME/.tmux.conf
	cp $DIR/zshrc $HOME/.zshrc
	cp $DIR/flake8 $HOME/.config/flake8
	cp -r $DIR/.vim/UltiSnips $HOME/.vim
	cp -r $DIR/.vim/ftplugin $HOME/.vim
fi

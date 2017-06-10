#!/bin/sh

DIR=`pwd`
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++ 1. Store ConfigFile  +++++++++++++++"
echo "++++++++++++++  2. Restore ConfigFile ++++++++++++++"
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++"
read -p "Input the choice:" choice
if [ $choice -eq 1 ];then
	echo Store ConfigFile $DIR from $HOME ...
	cp $HOME/.vimrc $DIR
	cp $HOME/.tmux.conf $DIR
	cp $HOME/.zshrc $DIR
	if [ ! -d $DIR/.vim ];then
		mkdir $DIR/.vim
	fi
	cp -r $HOME/.vim/UltiSnips $DIR/.vim
	cp -r $HOME/.vim/ftplugin $DIR/.vim
fi
if [ $choice -eq 2 ];then
	if [ ! -a "$HOME/.vim/autoload/plug.vim" ];then
		curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	fi
	echo Restore ConfigFile from $DIR ...
	cp $DIR/.vimrc $HOME
	cp $DIR/.tmux.conf $HOME
	cp $DIR/.zshrc $HOME
	if [ ! -d "$HOME/.vim" ];then
		mkdir $HOME/.vim
	fi
	cp -r $DIR/.vim/UltiSnips $HOME/.vim
	cp -r $DIR/.vim/ftplugin $HOME/.vim
fi

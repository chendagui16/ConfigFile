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
	[[ ! -d $DIR/.vim ]] && mkdir $DIR/.vim
	cp -r $HOME/.vim/UltiSnips $DIR/.vim
	cp -r $HOME/.vim/ftplugin $DIR/.vim
fi
if [ $choice -eq 2 ];then
	[[ ! -d "$HOME/.vim" ]] && mkdir $HOME/.vim
	[[ ! -d "$HOME/.vim/undo" ]] && mkdir $HOME/.vim/undo
	[[ ! -d "$HOME/.vim/tags" ]] && mkdir $HOME/.vim/tags
	[[ ! -d "$HOME/.config" ]] && mkdir $HOME/.config
	if [ ! -f "$HOME/.vim/autoload/plug.vim" ];then
		curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	fi
	echo Restore ConfigFile from $DIR ...
	cp $DIR/vimrc $HOME
	cp $DIR/tmux.conf $HOME
	cp $DIR/zshrc $HOME
	cp $DIR/flake8 $HOME/.config
	cp -r $DIR/.vim/UltiSnips $HOME/.vim
	cp -r $DIR/.vim/ftplugin $HOME/.vim
fi

#!/bin/bash

set -e

if ! hash vim 2>/dev/null ; then
    echo "Error: Not installed VIM"
    exit 1
fi


if [ ! -e ~/.vimrc ]; then ln -s $(pwd)/vimrc ~/.vimrc; fi
if [ ! -d ~/.vim ]; then ln -s $(pwd)/vim ~/.vim; fi
if [ ! -e ~/.ctags ]; then  ln -s $(pwd)/ctags ~/.ctags; fi

if [ ! -e ~/.vim/bundle/Vundle.vim ]
    then
        cd ~/.vim && git clone https://github.com/VundleVim/Vundle.vim bundle/Vundle.vim && vim +BundleInstall
fi

if hash nvim 2>/dev/null ; then

    mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
    ln -s -f ~/.vim $XDG_CONFIG_HOME/nvim
    ln -s -f ~/.vimrc $XDG_CONFIG_HOME/nvim/init.vim

fi

# Install fonts
font_dir="$HOME/.local/share/fonts"
if [ ! -d "$font_dir" ]; then mkdir -p "$font_dir"; fi

cp ./vim/fonts/* $font_dir

# Reset font cache on Linux
if [[ -n $(which fc-cache) ]]; then
  fc-cache -f "$font_dir"
fi

if [[ ! -n $(which ctags) ]]; then
  echo 'info: ctags not installed'
fi



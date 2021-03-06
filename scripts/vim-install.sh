#!/usr/bin/env bash

if [[ ! -e `which git` ]]; then
    echo 'not found git'
    exit 1;
fi 

DIST_VIM=/tmp/vim

if [[ ! -d $DIST_VIM ]]; then
    git clone https://github.com/vim/vim.git $DIST_VIM
else [[ -d $DIST_VIM ]];
    git -C $DIST_VIM pull origin master 
fi

cd $DIST_VIM

./configure \
    --prefix=$HOME/.local \
    --enable-multibyte \
    --enable-xim \
    --enable-fontset \
    --with-features=huge \
    --with-luajit \
    --with-lua-prefix=/usr/local/ \
    --enable-cscope \
    --enable-gui=no \
    --enable-gnome-check \
    --enable-luainterp=yes \
    --enable-rubyinterp=yes \
    --enable-pythoninterp=yes \
    --enable-python3interp=yes

make && make install

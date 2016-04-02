#!/bin/bash

DOT_FILES=( .bashrc .zsh .gitconfig .gitignore .emacs local)

for file in ${DOT_FILES[@]}
do
    if [ ! -e $HOME/$file ]; then
        ln -s $HOME/.dotfiles/$file $HOME/$file
    fi
done

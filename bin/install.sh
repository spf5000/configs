#!/bin/bash

# root_configs = [.vimrc .zshrc]

# for config in $root_configs; do
#     echo "$config"
# end

dotfiles=${ls -a $HOME/configs/root/*)}

# Assuming configs project in your home directory
for dotfile in dotfiles; do
    echo "linking .config directory -> $dotfile"
    file="$(basename $dotfile)"
    ln -sf $dotfile "$HOME/$file"
done


# Assuming configs project in your home directory
for dir in $HOME/configs/.config/*; do
    echo "linking .config directory -> $dir"
    file="$(basename $dir)"
    ln -sf $dir "$HOME/.config/$file"
done

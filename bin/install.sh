#!/bin/bash

# root_configs = [.vimrc .zshrc]

# for config in $root_configs; do
#     echo "$config"
# end

# Assuming configs project in your home directory
for dir in $HOME/configs/.config/*; do
    echo "File -> $dir"
    # echo "$(basename $dir)"
    file="$(basename $dir)"
    echo $file
    ln -sf $dir "$HOME/.config/$file"
done

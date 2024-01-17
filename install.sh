#!/bin/bash
sudo apt install composer npm
if [ -d ~/.config/nvim ]
then
    tar -czf ~/.config/nvim-old-config.tgz ~/.config/nvim
    rm -rf ~/.config/nvim
    echo "Old nvim config saved in ~/.config/nvim-old-config.tgz"
    if [ -d ~/.local/share/nvim ]
    then
        rm -rf ~/.local/share/nvim
	echo "Old local files deleted"
    fi
fi

cp -r nvim ~/.config/

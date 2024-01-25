#!/bin/bash
if ! nvim -v &> /dev/null
then
    echo "NeoVim is not installed on this machine. It will be installed first."
    if ! curl -v &> /dev/null
    then
        echo "This script require curl in order to install the latest nvim image. Will install curl first."
        echo "If you have sudo rights please continue, otherwise ask your IT to install them first."
        select yn in "Continue" "exit"
        do
            case $yn in
                Continue ) break ;;
                Exit ) exit ;;
            esac
        done
        sudo apt install curl
    fi
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage
    sudo mv nvim.appimage /usr/local/bin/nvim
    echo "You can launch nvim with the /usr/local/bin/nvim command."
    echo "Do you want to have an alias (it will be added in ~/.bash_aliases)?"
    select alias in "alias_vi" "alias_nvim" "no"
    do
        case $alias in
            no ) break ;;
            alias_vi ) echo "alias vi='/usr/local/bin/nvim'" >> ~/.bash_aliases
                break ;;
            alias_nvim ) echo "alias nvim='/usr/local/bin/nvim'" >> ~/.bash_aliases
                break ;;
        esac
    done
fi
if ! composer -v &> /dev/null || ! npm -v &> /dev/null
# Ask user for external softwares
then
    echo "This script requires composer & npm to be installed first."
    echo "If you have sudo rights please continue, otherwise ask your IT to install them first."
    select yn in "Continue" "Exit"
    do
        case $yn in
            Continue ) break ;;
            Exit ) exit ;;
        esac
    done
    for softs in "composer" "npm"
    do
        if ! $softs -v &> /dev/null
        then
            echo "Software $softs is not installed."
            echo "Now installing $softs."
            sudo apt install $softs
        fi
    done
else
    echo "Composer and npm already installed, proceeding with nvim configuration."
fi
if [ -d ~/.config/nvim ]
# Save old nvim config and install new one
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
cp .prettierrc.yaml ~/

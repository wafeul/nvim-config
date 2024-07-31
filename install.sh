#!/bin/bash
current_user=$(whoami)
echo "This install is for Ubuntu related OS only."
select yn in "Continue" "Exit"; do
    case $yn in
    Continue) break ;;
    Exit) exit ;;
    esac
done
if ! nvim -v &>/dev/null; then
    echo "NeoVim is not installed on this machine. It will be installed first."
    if ! curl -v &>/dev/null; then
        echo "This script require curl in order to install the latest nvim image. Will install curl first."
        echo "If you have sudo rights please continue, otherwise ask your IT to install curl first."
        select yn in "Continue" "Exit"; do
            case $yn in
            Continue) break ;;
            Exit) exit ;;
            esac
        done
        sudo apt install curl
    fi
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage
    sudo mv nvim.appimage /usr/local/bin/nvim
    echo "You can launch nvim with the /usr/local/bin/nvim command."
    echo "Do you want to have an alias (it will be added in ~/.bash_aliases)?"
    select alias in "vi" "nvim" "no"; do
        case $alias in
        no) break ;;
        vi)
            echo "alias vi='/usr/local/bin/nvim'" >>~/.bash_aliases
            break
            ;;
        nvim)
            echo "alias nvim='/usr/local/bin/nvim'" >>~/.bash_aliases
            break
            ;;
        esac
    done
    echo "You can launch nvim in diff mode with the /usr/local/bin/nvim -d command."
    echo "Do you want to have an alias (it will be added in ~/.bash_aliases)?"
    select alias_diff in "vimdiff" "nvimdiff" "no"; do
        case $alias_diff in
        no) break ;;
        vimdiff)
            echo "alias vimdiff='/usr/local/bin/nvim -d'" >>~/.bash_aliases
            break
            ;;
        nvimdiff)
            echo "alias nvimdiff='/usr/local/bin/nvim -d'" >>~/.bash_aliases
            break
            ;;
        esac
    done
fi
# Ask user for external softwares
if ! composer --version &>/dev/null || ! npm --version &>/dev/null || ! fdfind --version &>/dev/null || ! rg --version &>/dev/null; then
    echo "This script requires ripgrep, fd-find, composer & npm to be installed first."
    echo "If you have sudo rights please continue, otherwise ask your IT to install them first."
    select yn in "Continue" "Exit"; do
        case $yn in
        Continue) break ;;
        Exit) exit ;;
        esac
    done
    for softs in "rg" "fdfind" "composer" "npm"; do
        if ! $softs --version &>/dev/null; then
            if [[ $softs == "rg" ]]; then
                softs="ripgrep"
            elif [[ $softs == "fdfind" ]]; then
                softs="fd-find"
            fi
            echo "Software $softs is not installed."
            echo "Now installing $softs."
            sudo apt install $softs
        fi
    done
else
    echo "Composer and npm already installed, proceeding with lazygit installation."
fi
if ! lazygit --version &>/dev/null; then
    echo "The following step will install lazygit on your computer and configure neovim to use it"
    echo "Do you wish to install lazygit?"
    select yn in "Yes" "No"; do
        case $yn in
        Yes)
            LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
            curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
            tar xf lazygit.tar.gz lazygit
            sudo install lazygit /usr/local/bin
            rm lazygit
            rm lazygit.tar.gz
            break
            ;;
        No) break ;;
        esac
    done
    if [ -s ~/.config/lazygit/config.yml ] &>/dev/null; then
        echo "Your lazyGit config file is not empty. Do you wish to replace it with the one from this repo?"
        select yn in "Yes" "No"; do
            case $yn in
            Yes)
                cp ./externals/lazygit/config.yml ~/.config/lazygit/config.yml
                break
                ;;
            No) break ;;
            esac
        done
    else
        cp ./externals/lazygit/config.yml ~/.config/lazygit/config.yml
    fi
else
    echo "lazygit already installed, proceeding with nerd fonts."
fi
if ! fc-list | grep DejaVuSansMono &>/dev/null; then
    echo "DejaVuSansMono nerdfont not found, do you wish to install it?"
    echo "This is helpfull to have icons inside nvim."
    select yn in "Yes" "No"; do
        case $yn in
        Yes)
            if [ ! -d ~/.local/share/fonts/ ]; then
                mkdir ~/.local/share/fonts/
            fi
            mkdir ~/.local/share/fonts/DejaVuSansMono/
            unzip ./externals/nerdfonts/DejaVuSansMono.zip -d ~/.local/share/fonts/DejaVuSansMono/
            fc-cache -fv
            break
            ;;
        No) break ;;
        esac
    done
else
    echo "DejaVuSansMono nerdfont already installed, processing with nvim config."
fi
if [ -d ~/.config/nvim ]; then
    echo "Save old nvim config and install new one"
    tar -czf ~/.config/nvim-old-config.tgz ~/.config/nvim 2>/dev/null
    rm -rf ~/.config/nvim
    echo "Old nvim config saved in ~/.config/nvim-old-config.tgz"
    if [ -d ~/.local/share/nvim ]; then
        tar -czf ~/.local/share/nvim-old-config.tgz ~/.local/share/nvim 2>/dev/null
        rm -rf ~/.local/share/nvim
        echo "Old local files saved in ~/.local/share/nvim-old-config.tgz"
    fi
fi

cp -r nvim ~/.config/
sed -i "s/rbourgeas/$current_user/g" ~/.config/nvim/lua/plugins/none-ls.lua
cp .prettierrc.yaml ~/

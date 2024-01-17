#!/bin/bash
if ! composer -v &> /dev/null || ! npm -v &> /dev/null
then
	echo "This script requires composer & npm to be installed first."
	echo "If you have sudo rights please continue, otherwise ask your IT to install them first."
	select yn in "Continue" "Exit"
	do
		case $yn in
			Continue ) break;;
			Exit ) exit;;
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
	# if ! composer -v &> /dev/null
	# then
	#     sudo apt install composer
	# fi
	# if ! npm -v &> /dev/null
	# then
	#     sudo apt install npm
	# fi
else
	echo "Composer and npm already installed, proceeding with nvim configuration."
fi
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

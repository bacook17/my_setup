SHELL=/bin/bash

my_setup: emacs bash latex git matplotlib

emacs:	./.emacs
	cp .emacs ~/
	-mkdir ~/.emacs.d/
	-mkdir ~/.emacs.d/lisp
	cp ./.emacs.d/lisp/* ~/.emacs.d/lisp/
	-mkdir ~/scripts/
	cp ./scripts/pychecker ~/scripts/pychecker
	chmod +x ~/scripts/pychecker

matplotlib:
	-mkdir ~/.config/
	-mkdir ~/.config/matplotlib/
	-mkdir ~/.config/matplotlib/stylelib/
	cp mplstylefiles/* ~/.config/matplotlib/stylelib/

bash:	./cook_bash.sh
	cp ./cook_bash.sh ~/cook_bash.sh
	if grep -q "cook_bash.sh" ~/.bashrc; then echo ".bashrc all set"; \
		else echo "source ~/cook_bash.sh" >> ~/.bashrc; fi
	if grep -q "cook_bash.sh" ~/.bash_profile; then echo ".bash_profile all set"; \
		else echo "source ~/cook_bash.sh" >> ~/.bash_profile; fi
	source ~/cook_bash.sh

latex: ./latexdriver
	-mkdir ~/scripts
	cp ./scripts/latexdriver ~/scripts/latexdriver
	chmod +x ~/scripts/latexdriver

git: ./.gitconfig ./.gitignore
	-cp ~/.gitconfig ~/.gitconfig_old
	cp ./.gitconfig ~/.gitconfig
	-cp ~/.gitignore ~/.gitignore_old
	cp ./.gitignore ~/.gitignore

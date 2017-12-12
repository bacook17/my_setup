SHELL=/bin/bash
my_setup: emacs bash latex git

emacs:	./.emacs
	cp .emacs ~/
	-mkdir ~/.emacs.d/
	-mkdir ~/.emacs.d/lisp
	cp ./.emacs.d/lisp/* ~/.emacs.d/lisp/
	-mkdir ~/scripts/
	cp ./scripts/pychecker ~/scripts/pychecker
	chmod +x ~/scripts/pychecker

bash:	./my_bash.sh
	cp ./my_bash.sh ~/my_bash.sh
	if grep -q "my_bash.sh" ~/.bashrc; then echo ".bashrc all set"; \
		else echo "source ~/my_bash.sh" >> ~/.bashrc; fi
	if grep -q "my_bash.sh" ~/.bash_profile; then echo ".bash_profile all set"; \
		else echo "source ~/my_bash.sh" >> ~/.bash_profile; fi
	source ~/my_bash.sh

latex: ./latexdriver
	-mkdir ~/scripts
	cp ./scripts/latexdriver ~/scripts/latexdriver
	chmod +x ~/scripts/latexdriver

git: ./.gitconfig ./.gitignore
	-cp ~/.gitconfig ~/.gitconfig_old
	cp ./.gitconfig ~/.gitconfig
	-cp ~/.gitignore ~/.gitignore_old
	cp ./.gitignore ~/.gitignore

my_setup: emacs bash latex git

emacs:	./.emacs
	cp .emacs ~/
	-mkdir ~/.emacs.d/
	-mkdir ~/.emacs.d/lisp
	cp ./.emacs.d/lisp/* ~/.emacs.d/lisp/
	-mkdir ~/scripts/
	cp ./scripts/pychecker ~/scripts/pychecker
	chmod +x ~/scripts/pychecker

bash:	./.bash_profile
	-cp ~/.bash_profile ~/.bash_profile_old
	-cp ~/.bashrc ~/.bashrc_old
	cp ./.bash_profile ~/.bash_profile
	cp ./.bashrc ~/.bashrc

latex: ./latexdriver
	-mkdir ~/scripts
	cp ./scripts/latexdriver ~/scripts/latexdriver
	chmod +x ~/scripts/latexdriver

git: ./.gitconfig ./.gitignore
	-cp ~/.gitconfig ~/.gitconfig_old
	cp ./.gitconfig ~/.gitconfig
	-cp ~/.gitignore ~/.gitignore_old
	cp ./.gitignore ~/.gitignore

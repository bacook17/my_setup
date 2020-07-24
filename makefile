SHELL=/bin/bash
NOW=$(shell date +'%Y%m%d%H%M%S')

all: python linux

python: conda environment extensions matplotlib

linux: bash latex git emacs

bash:
	-ln -s ./cook_bash.sh ~/cook_bash.sh
	@if grep -q "cook_bash.sh" ~/.bashrc; then echo ".bashrc all set"; \
		else echo "source ~/cook_bash.sh" >> ~/.bashrc; fi
	@if grep -q "cook_bash.sh" ~/.bash_profile; then echo ".bash_profile all set"; \
		else echo "source ~/cook_bash.sh" >> ~/.bash_profile; fi

latex:
	-@mkdir ~/scripts
	-ln -s ./scripts/latexdriver ~/scripts/latexdriver

git:
	-cp ~/.gitconfig ~/.gitconfig_$(NOW)
	cp ./.gitconfig ~/.gitconfig
	-cp ~/.gitignore_global ~/.gitignore_global_$(NOW)
	cp ./.gitignore ~/.gitignore

conda:
	-@sh install_conda.sh
	-@rm Miniconda3-latest-Linux-x86_64.sh

environment:
	@conda env create -f environment.yml
	@echo "\n\n**********\nIMPORTANT:\nIt is now recommended that you add the following to your .bashrc file: \n"
	@echo "conda activate ben.cook.qr"
	@echo "\nso this environment is activated upon connecting\n**********\n"

extensions:
	-@./install_extensions.sh

emacs:
	-cp ~/.emacs ~/.emacs_$(NOW)
	cp .emacs ~/.emacs
	-mkdir ~/.emacs.d/
	-mkdir ~/.emacs.d/lisp || cp ~/.emacs.d/lisp ~/.emacs.d/list_$(NOW)
	cp ./.emacs.d/lisp/* ~/.emacs.d/lisp/
	-mkdir ~/scripts/ || cp ~/scripts ~/scripts_$(NOW)
	cp ./scripts/pychecker ~/scripts/pychecker
	chmod +x ~/scripts/pychecker

matplotlib:
	-mkdir ~/.config/
	-mkdir ~/.config/matplotlib/
	-mkdir ~/.config/matplotlib/stylelib/
	cp mplstylefiles/* ~/.config/matplotlib/stylelib/


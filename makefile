SHELL=/bin/bash
NOW=$(shell date +'%Y%m%d%H%M%S')
ENVIRONMENT="ben.cook.default"

all: bash latex git conda home_environment extensions emacs matplotlib

bash:
	-ln -s ./cook_bash.sh ~/cook_bash.sh
	@if grep -q "cook_bash.sh" ~/.bashrc; then echo ".bashrc all set"; \
		else echo "source ~/cook_bash.sh" >> ~/.bashrc; fi
	@if grep -q "cook_bash.sh" ~/.bash_profile; then echo ".bash_profile all set"; \
		else echo "source ~/cook_bash.sh" >> ~/.bash_profile; fi

latex:
	-@mkdir ~/scripts
	-cp ~/scripts/latexdriver_$(NOW)
	cp ./scripts/latexdriver ~/scripts/latexdriver
	@chmod +x ~/scripts/latexdriver

git:
	-cp ~/.gitconfig ~/.gitconfig_$(NOW)
	cp ./.gitconfig ~/.gitconfig
	-cp ~/.gitignore ~/.gitignore_$(NOW)
	cp ./.gitignore ~/.gitignore

conda:
	-@sh install_conda.sh
	-@rm Miniconda3-latest-Linux-x86_64.sh
	-@rm Miniconda3-latest-MacOSX-x86_64.sh

environment:
	@conda env create -f environment.yml
	@if grep -q "conda activate $(ENVIRONMENT)" ~/.bashrc; then echo ".bashrc all set"; \
		else echo "conda activate $(ENVIRONMENT)" >> ~/.bashrc; fi
	@if grep -q "conda activate $(ENVIRONMENT)" ~/.bash_profile; then echo ".bash_profile all set"; \
		else echo "conda activate $(ENVIRONMENT)" >> ~/.bash_profile; fi

extensions:
	-@./install_extensions.sh $(ENVIRONMENT)

emacs:	./.emacs
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


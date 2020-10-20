SHELL=/bin/bash
NOW=$(shell date +'%Y%m%d%H%M%S')
ENVIRONMENT="ben.cook.default"

all: python linux

python: conda environment extensions matplotlib

linux: bash latex git emacs

bash:
	-ln -s "${PWD}/cook_bash.sh" ~/cook_bash.sh
	@if grep -q "cook_bash.sh" ~/.bashrc; then echo ".bashrc all set"; \
		else echo "source ~/cook_bash.sh" >> ~/.bashrc; fi
	@if grep -q "cook_bash.sh" ~/.bash_profile; then echo ".bash_profile all set"; \
		else echo "source ~/cook_bash.sh" >> ~/.bash_profile; fi

latex:
	-@mkdir ~/scripts
	-ln -s "${PWD}/scripts/latexdriver" ~/scripts/latexdriver

git:
	-cp ~/.gitconfig ~/.gitconfig_$(NOW)
	cp ./.gitconfig ~/.gitconfig
	-cp ~/.gitignore_global ~/.gitignore_global_$(NOW)
	cp ./.gitignore_global ~/.gitignore_global

conda:
	-@sh install_conda.sh
	-@rm Miniconda3-latest-Linux-x86_64.sh
	-@rm Miniconda3-latest-MacOSX-x86_64.sh
	-@conda activate base && conda install mamba

environment:
	@mamba env create -f environment.yml || conda env create -f environment.yml
	-@if grep -q "conda activate $(ENVIRONMENT)" ~/.bashrc; then echo ".bashrc all set"; \
		else echo "conda activate $(ENVIRONMENT)" >> ~/.bashrc; fi
	-@if grep -q "conda activate $(ENVIRONMENT)" ~/.bash_profile; then echo ".bash_profile all set"; \
		else echo "conda activate $(ENVIRONMENT)" >> ~/.bash_profile; fi
	-@conda activate $(ENVIRONMENT) && python -m ipykernel install --user --name $(ENVIRONMENT) --display-name "Python3 ($(ENVIRONMENT))"

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


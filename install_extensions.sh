if [ $# -eq 0 ]; then echo "Must pass an environment name" && exit 1; fi
source ~/miniconda3/etc/profile.d/conda.sh
echo "activating environment ${1}"
conda activate $1
echo "installing jupyterlab extensions"
jupyter labextension install @jupyter-widgets/jupyterlab-manager
jupyter labextension install @ryantam626/jupyterlab_code_formatter
jupyter serverextension enable --py jupyterlab_code_formatter
jupyter labextension install @aquirdturtle/collapsible_headings
jupyter labextension install @jupyterlab/toc
jupyter labextension install @bokeh/jupyter_bokeh
echo "finalizing build"
jupyter lab build

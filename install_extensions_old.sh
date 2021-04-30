source ~/miniconda3/etc/profile.d/conda.sh
echo "activating environment ben.cook.qr"
conda activate ben.cook.qr
echo "installing jupyterlab extensions"
jupyter labextension install @jupyter-widgets/jupyterlab-manager
jupyter labextension install @ryantam626/jupyterlab_code_formatter
jupyter serverextension enable --py jupyterlab_code_formatter
jupyter labextension install @aquirdturtle/collapsible_headings
jupyter labextension install @jupyterlab/toc
jupyter labextension install @jupyterlab/git
jupyter labextension install @bokeh/jupyter_bokeh
echo "finalizing build"
jupyter lab build

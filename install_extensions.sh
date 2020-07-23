conda activate ben_cook_qr
jupyter labextension install @jupyter-widgets/jupyterlab-manager
jupyter labextension install @ryantam626/jupyterlab_code_formatter@0.2.3
jupyter serverextension enable --py jupyterlab_code_formatter
jupyter labextension install @aquirdturtle/collapsible_headings
jupyter labextension install @jupyterlab/toc
jupyter labextension install @bokeh/jupyter_bokeh
jupyter lab build

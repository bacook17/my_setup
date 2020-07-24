if which conda 2> /dev/null; then
    echo "Conda already installed";
else
    echo "\n\nConda is not installed. Will install it now.\n\n";
    wget -q https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh;
    sh Miniconda3-latest-Linux-x86_64.sh;
    rm Miniconda3-latest-Linux-x86_64.sh;
fi

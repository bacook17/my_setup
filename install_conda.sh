if [[ $HOSTNAME == *"MacBook"* ]]; then
    FILENAME="Miniconda3-latest-MacOSX-x86_64.sh";
else
    FILENAME="Miniconda3-latest-Linux-x86_64.sh";
fi
if which conda 2> /dev/null; then
    echo "Conda already installed";
else
    echo "\n\nConda is not installed. Will install it now.\n\n";
    curl -LO "https://repo.continuum.io/miniconda/${FILENAME}";
    sh $FILENAME;
    rm $FILENAME;
fi

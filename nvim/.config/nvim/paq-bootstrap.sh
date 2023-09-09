#!/bin/sh
set -eu

echo "Installing paq-nvim..."
git clone --depth=1 https://github.com/savq/paq-nvim.git \
    "$HOME"/.local/share/nvim/site/pack/paqs/start/paq-nvim
nvim "+PaqInstall"

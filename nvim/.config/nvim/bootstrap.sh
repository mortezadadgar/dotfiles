#!/bin/sh
set -eu
install_path="$HOME/.local/share/nvim/site/pack/paqs/start/paq-nvim"

if [ -d "$install_path" ]; then
	echo "paq-nvim is already installed"
	exit
fi

git clone --depth=1 https://github.com/savq/paq-nvim.git "$install_path"
nvim "+PaqInstall"

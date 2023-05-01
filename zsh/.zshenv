# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$XDG_DATA_HOME/go/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# Default programs
export SUDO_EDITOR="nvim"
export EDITOR="nvim"
export BROWSER="firefox"
export LIBVA_DRIVER_NAME="iHD"

# Zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# X11
export XINITRC="$XDG_CONFIG_HOME/x11/xinitrc"

# Golang
export GOPATH="$XDG_DATA_HOME/go"
export GO111MODULE="on"
export GOPROXY="https://proxy.golang.org,direct"

# Other programs
export MAKEFLAGS="-j$(nproc)"
export LESS="-x4Rg"

# man page highlighting
export LESS_TERMCAP_md=$'\e[01;34m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;44;30m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;32m'
export LESS_TERMCAP_ue=$'\e[0m'

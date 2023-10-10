# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$XDG_DATA_HOME/go/bin:$PATH"
export PATH="$XDG_DATA_HOME/cargo/bin:$PATH"

# Default programs
export EDITOR="nvim"
export BROWSER="firefox"

# Clean up ~
export XINITRC="$XDG_CONFIG_HOME/x11/xinitrc"
export ANDROID_HOME="$XDG_DATA_HOME/android"
export GOPATH="$XDG_DATA_HOME/go"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export NPM_CONFIG_PREFIX="$XDG_DATA_HOME/npm"
export ZSHZ_DATA="$XDG_DATA_HOME/z"

# zsh
export ZDOTDIR="$HOME/.config/zsh"

# Other programs
export LESS="-x4Rg"
export SYSTEMD_LESS=$LESS
export LS_COLORS="$(<$XDG_CONFIG_HOME/zsh/lscolors)"
export MANPAGER='nvim +Man! +"set nocul" +"set ls=0" +"set nonu"'

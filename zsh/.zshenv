export ZDOTDIR="$HOME/.config/zsh"

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$XDG_DATA_HOME/go/bin:$PATH"
export PATH="$XDG_DATA_HOME/cargo/bin:$PATH"
export PATH="$XDG_DATA_HOME/nvim/mason/bin/:$PATH"
export PATH="$XDG_DATA_HOME/npm/bin/:$PATH"

# Default programs
export EDITOR="nvim"
export BROWSER="brave"

# Clean up ~
export XINITRC="$XDG_CONFIG_HOME/x11/xinitrc"
export ANDROID_HOME="$XDG_DATA_HOME/android"
export GOPATH="$XDG_DATA_HOME/go"
export CARGO_HOME="$XDG_DATA_HOME/cargo"

# password store
export PASSWORD_STORE_CLIP_TIME="120"
export PASSWORD_STORE_GENERATED_LENGTH="16"

# nnn
export NNN_FIFO="/tmp/nnn.fifo"
export NNN_PLUG="f:preview-tui"
export NNN_OPENER="open"

# Less options
export LESS="-x4Rg"
export SYSTEMD_LESS=$LESS

# bat
export BAT_THEME="rose-pine"
export NNN_BATTHEME="rose-pine"
export BAT_STYLE="plain"
export NNN_BATSTYLE="plain"

# Other programs
export FZF_DEFAULT_OPTS="--layout=reverse --height=10% --no-separator --color=hl+:blue,hl:blue,fg+:#E0DEF4,bg+:#26233A,pointer:white,spinner:blue,info:green,prompt:cyan"
export QT_QPA_PLATFORMTHEME=gtk3
export MANPAGER="nvim +Man!"

# man page highlighting
export MANROFFOPT="-c"
export LESS_TERMCAP_md="$(tput bold; tput setaf 5)"
export LESS_TERMCAP_me="$(tput sgr0)"
export LESS_TERMCAP_us="$(tput bold; tput setaf 2)"
export LESS_TERMCAP_ue="$(tput sgr0)"

# LS_COLORS
(( $+commands[dircolors] )) && eval `dircolors`

# private variables
[ -f "$HOME/.zshenv_pri" ] && source "$HOME/.zshenv_pri"

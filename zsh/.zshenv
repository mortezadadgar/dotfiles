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
export PATH="/usr/share/git/git-jump:$PATH"

# Default programs
export EDITOR="nvim"
export BROWSER="firefox"
export TERMINAL="foot"

# Clean up ~
export XINITRC="$XDG_CONFIG_HOME/x11/xinitrc"
export ANDROID_HOME="$XDG_DATA_HOME/android"
export GOPATH="$XDG_DATA_HOME/go"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export NSS_DEFAULT_DB_DIR="$XDG_DATA_HOME/ki/nssdb"
export ADB_KEYS_PATH="$XDG_DATA_HOME/android"

# password store
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/pass"
export PASSWORD_STORE_CLIP_TIME="120"
export PASSWORD_STORE_GENERATED_LENGTH="16"

# nnn
export NNN_FIFO="/tmp/nnn.fifo"
export NNN_PLUG="p:preview-tui;d:diffs;f:fzcd"
export NNN_OPENER="open"
export NNN_OPTS="Ce"

# Less options
export LESS="-x4Rg"
export SYSTEMD_LESS="$LESS"

# bat
export {NNN_BATTHEME,BAT_THEME}="rose-pine"
export {BAT_STYLE,NNN_BATSTYLE}="plain"

# wayland
export ELECTRON_OZONE_PLATFORM_HINT="wayland"
export XDG_CURRENT_DESKTOP="wlroots"

# Fzf
export FZF_DEFAULT_OPTS="--layout=reverse --height=10% --no-separator --color=hl+:blue,hl:blue,fg+:#E0DEF4,bg+:#26233A,pointer:white,spinner:blue,info:green,prompt:cyan"

# Use gtk for qt theming
export QT_QPA_PLATFORMTHEME="gtk3"

# Default gtk theme
export GTK_THEME="Adwaita:dark"

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

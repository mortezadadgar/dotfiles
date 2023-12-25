# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$XDG_DATA_HOME/go/bin:$PATH"
export PATH="$XDG_DATA_HOME/cargo/bin:$PATH"
export PATH="$XDG_DATA_HOME/nvim/mason/bin/:$PATH"

# Default programs
export EDITOR="nvim"
export BROWSER="firefox"

# Clean up ~
export XINITRC="$XDG_CONFIG_HOME/x11/xinitrc"
export ANDROID_HOME="$XDG_DATA_HOME/android"
export GOPATH="$XDG_DATA_HOME/go"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export NPM_CONFIG_PREFIX="$XDG_DATA_HOME/npm"

# Other programs
export LESS="-x4Rg"
export SYSTEMD_LESS=$LESS
export FZF_DEFAULT_OPTS="--layout=reverse --height=10% --info=inline-right --color=hl+:blue,hl:blue,fg+:-1,bg+:#3e4451,pointer:white,spinner:blue,info:green,prompt:cyan"
export CHROMIUM_FLAGS="$(<$XDG_CONFIG_HOME/chromium-flags.conf)"
export GOPROXY="https://goproxy.cn"

# man page highlighting
export MANROFFOPT="-c"
export LESS_TERMCAP_md="$(tput bold; tput setaf 4)"
export LESS_TERMCAP_me="$(tput sgr0)"
export LESS_TERMCAP_us="$(tput bold; tput setaf 2)"
export LESS_TERMCAP_ue="$(tput sgr0)"

# LS_COLORS
(( $+commands[dircolors] )) && eval `dircolors`

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	exec startx
fi

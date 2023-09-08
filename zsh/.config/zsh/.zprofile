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
export ZSHZ_DATA="$XDG_DATA_HOME/z"

# Other programs
export LESS="-x4Rg"
export GRIM_DEFAULT_DIR="$HOME/Pictures/screenshots"
export LS_COLORS="$(<$XDG_CONFIG_HOME/zsh/lscolors)"
export BEMENU_OPTS="--fn JetBrainsMono Nerd Font 11px --tb #61afef --tf #282c34 --fb #282c34 --ff #c0c0c0 --nb #282c34 --nf #c0c0c0 --hb #61afef --hf #282c34 --ab=#282c34 --af=#c0c0c0 --hp 10px --cw 1px"

# man page highlighting
export LESS_TERMCAP_md=$'\e[01;34m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_so=$'\e[00;44;30m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;32m'
export LESS_TERMCAP_ue=$'\e[0m'

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	# exec startx
	exec dbus-launch --exit-with-session dwl -s '$XDG_CONFIG_HOME/dwl/autostart.sh' 2>>$HOME/dwl.log
	# exec dbus-daemon --session --address=unix:path=/run/user/1000/bus dwl -s '$XDG_CONFIG_HOME/dwl/autostart.sh' 2>$HOME/dwl.log
fi

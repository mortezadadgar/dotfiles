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
export MOZ_USE_XINPUT2=1
export MOZ_ENABLE_WAYLAND=1
export LESS="-x4Rg"
export SYSTEMD_LESS=$LESS
export LS_COLORS="$(<$XDG_CONFIG_HOME/zsh/lscolors)"

# man page highlighting
export MANROFFOPT="-c"
export LESS_TERMCAP_md="$(tput bold; tput setaf 4)"
export LESS_TERMCAP_me="$(tput sgr0)"
export LESS_TERMCAP_so="$(tput setab 4; tput setaf 0)"
export LESS_TERMCAP_se="$(tput sgr0)"
export LESS_TERMCAP_us="$(tput bold; tput setaf 2)"
export LESS_TERMCAP_ue="$(tput sgr0)"

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	while true; do
		exec dwl -s '$XDG_CONFIG_HOME/dwl/autostart.sh'
	done
fi

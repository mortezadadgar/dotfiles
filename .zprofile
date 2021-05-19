# PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$GOBIN:$PATH"

# golang
export GOPATH="$HOME/workspace/Go"
export GOBIN="$HOME/workspace/Go/bin"

# Default apps
export SUDO_EDITOR="nvim"
export EDITOR="nvim"
export BROWSER="firefox"
export TERM="st-256color"

# Other program settings
export MAKEFLAGS="-j$(nproc)"
export SXHKD_SHELL="/bin/sh"
export LESS="-x4R"
export FZF_DEFAULT_OPTS="
--color=dark
--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7"
export MOZ_X11_EGL=1
export MOZ_USE_XINPUT2=1

# man page
export LESS_TERMCAP_md=$'\e[01;34m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;44;30m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;32m'
export LESS_TERMCAP_ue=$'\e[0m'

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi

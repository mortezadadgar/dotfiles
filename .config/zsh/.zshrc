# prompt
source $ZDOTDIR/.prompt

# Zinit
source $ZDOTDIR/zinit/.zinitrc

# Misc
HISTFILE=$ZDOTDIR/.histfile
HISTSIZE=1200000
SAVEHIST=1000000
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_expire_dups_first
setopt hist_verify
setopt interactive_comments
setopt noflowcontrol

# zsh completion configuration
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu yes select
zstyle ':completion:*' menu select
autoload -Uz compinit && compinit
zmodload zsh/complist

# n^3
source $HOME/.config/nnn/config

# Exports
export SUDO_EDITOR=/usr/bin/nvim
export EDITOR=nvim
export BROWSER=firefox
export LESS="-x4R"
export MAKEFLAGS="-j$(nproc)"
export GOPATH=$HOME/scripts/Go
export GOBIN=$HOME/scripts/Go/bin

# Plugins -- Zinit
# snippets
zinit for \
	OMZL::key-bindings.zsh \
	OMZP::git \
	OMZP::archlinux \
	OMZP::systemd \
	OMZP::vi-mode

# No wait
zinit for \
	light-mode urbainvaes/fzf-marks

# wait"0"
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

# wait"1"
zinit wait"1" lucid for \
	ael-code/zsh-colored-man-pages

# Plugins configuration
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# vi mode
bindkey -v
VI_MODE_SET_CURSOR=true
KEYTIMEOUT=1

# Fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
export FZF_DEFAULT_OPTS="
--color=dark
--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7"

# Keybindings
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -s '^n' 'n\n'
bindkey -s '^s' 'sudo !!\n'
bindkey -s '^d' ''

# Aliases
alias pacman='pacman --color=auto'
alias grep='grep --color=auto'
alias mkdir='mkdir --parents'
alias yay='yay --color=auto'
alias sudo='sudo -v; sudo'
alias svi='sudoedit'
alias src='exec zsh'
alias nf='neofetch'
alias nnn='nnn -ex'
alias du='du -h'
alias cl='clear'
alias ht='htop'
alias vi='nvim'

# Zinit
__ZINIT="$HOME/.zinit/bin/zinit.zsh"
__ZINIT_BIN=$(echo $__ZINIT |sed 's/zinit\.zsh//')

if [[ ! -f "$__ZINIT" ]]; then
	if (( $+commands[git] )); then
		print -P '%F{blue}Installing zinit...%f'
		git clone https://github.com/zdharma/zinit.git $__ZINIT_BIN
	else
		print -P '%F{red}git not found%f'
		exit 1
	fi
fi

source "$__ZINIT"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Completion configuration
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu yes select
zmodload zsh/complist

# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=1200000
SAVEHIST=1000000
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_expire_dups_first

# Misc
setopt interactive_comments
setopt noflowcontrol
setopt globdots

# vi mode
bindkey -v
bindkey -v '^?' backward-delete-char
KEYTIMEOUT=1

# Fuzzy find history forward/backward
autoload up-line-or-beginning-search
autoload down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Additional keybindings
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'l' vi-forward-char
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^E" backward-delete-word
#bindkey '^W' backward-kill-word


#WORDCHARS=${WORDCHARS/\/}

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
	OMZP::git \
	OMZP::archlinux \
	OMZP::systemd

# No wait
zinit light-mode for \
	compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh' \
	sindresorhus/pure \
	kutsan/zsh-system-clipboard \
	urbainvaes/fzf-marks

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

# Autosuggestion
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Pure
PURE_PROMPT_SYMBOL=""
PURE_PROMPT_VICMD_SYMBOL=""
PURE_GIT_UP_ARROW="▲"
PURE_GIT_DOWN_ARROW="▼"
PURE_CMD_MAX_EXEC_TIME=45
zstyle :prompt:pure:git:branch color green
zstyle :prompt:pure:path color blue
zstyle ':prompt:pure:prompt:*' color green

# n^3
if command -v nnn > /dev/null; then
	source $HOME/.config/nnn/config
	bindkey -s '^N' 'n\n'
fi

# Fzf
if command -v fzf > /dev/null; then
	source /usr/share/fzf/key-bindings.zsh
	source /usr/share/fzf/completion.zsh
	export FZF_DEFAULT_OPTS="
	--color=dark
	--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
	--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7"
fi

# ZLE hooks for vi mode status
function zle-keymap-select zle-line-init {
case $KEYMAP in
	vicmd) echo -ne '\e[1 q';;      # block
	viins|main) echo -ne '\e[5 q';; # beam
esac
}
zle -N zle-line-init
zle -N zle-keymap-select

# Aliases
alias pacman='pacman --color=auto'
alias sc-status='sudo systemctl status'
alias grep='grep --color=auto'
alias ls='ls --color=auto -p'
alias mkdir='mkdir --parents'
alias yay='yay --color=auto'
alias sudo='sudo -v; sudo'
alias svi='sudoedit'
alias src='exec zsh'
alias nf='neofetch'
alias n='nnn -eux'
alias du='du -h'
alias ht='htop'
alias vi='nvim'

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

# Essential keybindings
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'l' vi-forward-char
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

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

# Autosuggestion configuration
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Pure
PURE_PROMPT_SYMBOL=""
PURE_PROMPT_VICMD_SYMBOL=""
PURE_CMD_MAX_EXEC_TIME=45
zstyle :prompt:pure:git:branch color green
zstyle :prompt:pure:path color blue
zstyle ':prompt:pure:prompt:*' color green

# n^3
source $HOME/.config/nnn/config
bindkey -s '^n' 'n\n'

# Fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
export FZF_DEFAULT_OPTS="
--color=dark
--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7"

# Aliases
alias pacman='pacman --color=auto'
alias grep='grep --color=auto'
alias mkdir='mkdir --parents'
alias yay='yay --color=auto'
alias sudo='sudo -v; sudo'
alias svi='sudoedit'
alias src='exec zsh'
alias nf='neofetch'
alias n='nnn -ex'
alias du='du -h'
alias cl='clear'
alias ht='htop'
alias vi='nvim'

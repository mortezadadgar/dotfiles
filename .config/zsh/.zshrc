# prompt
source $ZDOTDIR/.prompt

# Zinit
if [[ ! -f $HOME/.config/zsh/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.config/zsh/.zinit" && command chmod g-rwX "$HOME/.config/zsh/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.config/zsh/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.config/zsh/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

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
zstyle ':completion:*' menu select
zstyle ':completion:*:default' menu yes select
autoload -Uz compinit && compinit
zmodload zsh/complist

# aliases
source $ZDOTDIR/.aliasrc

# n^3
source $HOME/.config/nnn/config

# Exports
export FZF_DEFAULT_OPTS="
--color=dark
--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7"
export SUDO_EDITOR=/usr/bin/nvim
export EDITOR=nvim
export BROWSER=firefox
export LESS="-x4R"
export MAKEFLAGS="-j$(nproc)"
export GOPATH=$HOME/scripts/Go
export GOBIN=$HOME/scripts/Go/bin

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# Plugins -- Zinit
# No wait
zinit light-mode for \
	zsh-users/zsh-history-substring-search \
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

# Plugins configuration
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=blue,fg=black,bold'
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=black,bold'
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Keybindings
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -s '^n' 'n\n'
bindkey -s '^s' 'sudo !!\n'
bindkey -s '^d' ''

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins
    echo -ne "\e[5 q"
}
zle -N zle-line-init

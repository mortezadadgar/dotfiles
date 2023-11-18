# Prompt
[[ $SSH_CONNECTION ]] && local uath='%F{green}%M%f '
PROMPT=$'${uath}%F{blue}%B%(7~|...%5~|%~)%f%b $(gitstatus)\n%F{green}%B➜%b%f '
precmd() { precmd() { print "" } }

# Options
setopt share_history hist_ignore_space hist_ignore_dups
setopt glob_complete globstarshort globdots complete_in_word extendedglob
setopt interactive_comments
setopt noflowcontrol
setopt prompt_subst
setopt auto_pushd pushd_ignore_dups cd_silent

# History
HISTFILE="$HOME/.zhistory"
HISTSIZE=100000
SAVEHIST=100000

# Completion
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zstyle ":completion:*:default" list-colors ${(s.:.)LS_COLORS} "ma=48;5;12;38;5;0"
zstyle ':completion:*:default' menu yes select
zstyle ':completion:*' rehash true
autoload -U compinit; compinit
zmodload zsh/complist

# only list files for open command
compdef _files open

# up and down keys to search history
autoload up-line-or-beginning-search
autoload down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# push line for vi mode
bindkey '^Q' push-line

# Allow backspace to remove newlines
bindkey '^?' backward-delete-char

# vi mode tab completion
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'l' vi-forward-char

# vi mode
bindkey -v
KEYTIMEOUT=1

# Git branch name
function gitstatus() {
	ref=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
	print "%F{green}${ref}%f"
}

# Change cursor shape for different vi modes
function zle-keymap-select() {
    case $KEYMAP in
        vicmd) print -n '\e[2 q';;      # block
        viins|main) print -n '\e[6 q';; # beam
    esac
}
zle -N zle-keymap-select
function zle-line-init() {
    print -n "\e[6 q" # beam
}
zle -N zle-line-init

# Support system clipboard
function vi-clip {
	case $KEYS in
		y) zle vi-yank;;
		d) zle vi-delete;;
	esac
	echo "$CUTBUFFER" | xclip -r -sel clip
}
zle -N vi-clip
bindkey -M vicmd 'y' vi-clip
bindkey -M vicmd 'd' vi-clip

# Edit line in editor
autoload edit-command-line; zle -N edit-command-line
bindkey '^E' edit-command-line

. $ZDOTDIR/aliasrc 2>/dev/null
. /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh 2>/dev/null

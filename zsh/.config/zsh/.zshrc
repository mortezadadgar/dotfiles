# Change prompt
[[ $SSH_CONNECTION ]] && local uath='%F{green}%M%f '
PROMPT=$'${uath}%F{blue}%B%(7~|...%5~|%~)%f%b $(git-info)\n%F{green}%B➜%b%f '
precmd() { precmd() { print "" } }

# Options
setopt share_history hist_ignore_space hist_ignore_dups
setopt interactive_comments
setopt noflowcontrol
setopt complete_in_word
setopt prompt_subst
setopt globdots
setopt cd_silent

# History
HISTFILE="$HOME/.zhistory"
HISTSIZE=100000
SAVEHIST=100000

# Completion
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*:default' menu yes select
fpath+=($ZDOTDIR/plugins/zsh-z)
autoload -U compinit; compinit
zmodload zsh/complist

# Ls colors
export LS_COLORS=$(cat $XDG_CONFIG_HOME/zsh/.lscolors)

# Auto rehash
zstyle ':completion:*' rehash true

# Fuzzy find history
autoload up-line-or-beginning-search
autoload down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

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
function git-info() {
	ref=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
	print "%F{green}${ref}%f"
}

# Change cursor shape for different vi modes
function zle-keymap-select() {
    case $KEYMAP in
        vicmd) print -n '\e[1 q';;      # block
        viins|main) print -n '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
function zle-line-init() {
    print -n "\e[5 q" # beam
}
zle -N zle-line-init

# Edit line in editor
autoload edit-command-line; zle -N edit-command-line
bindkey '^E' edit-command-line

# Aliases
. $ZDOTDIR/.aliasrc

# zsh-autosuggestions
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# Plugins
for file in $ZDOTDIR/plugins/*/*.plugin.zsh(N@,.); do
	. "$file"
done

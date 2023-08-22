# Change prompt
[[ $SSH_CONNECTION ]] && local uath='%F{green}%M%f '
PROMPT=$'${uath}%F{blue}%B%(7~|...%5~|%~)%f%b $(gitstatus)\n%F{green}%B➜%b%f '
precmd() { precmd() { print "" } }

# Options
setopt share_history hist_ignore_space hist_ignore_dups
setopt globstarshort globdots complete_in_word extendedglob
setopt interactive_comments
setopt noflowcontrol
setopt prompt_subst
setopt cd_silent

# History
HISTFILE="$HOME/.zhistory"
HISTSIZE=100000
SAVEHIST=100000

# Ls colors
export LS_COLORS="$(<$XDG_CONFIG_HOME/zsh/.lscolors)"

# Completion
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zstyle ":completion:*:default" list-colors ${(s.:.)LS_COLORS} "ma=48;5;12;38;5;0"
zstyle ':completion:*:default' menu yes select
zstyle ':completion:*' rehash true
fpath+=($ZDOTDIR/plugins/zsh-z) # source before compinit
autoload -U compinit; compinit
zmodload zsh/complist

# Rebind TAB to make it work with globbing expansion
bindkey $'\t' complete-word
zstyle ':completion:*' completer _expand _complete _ignored
zstyle :completion::expand::: tag-order expansions original

# Fuzzy find history
autoload up-line-or-beginning-search
autoload down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search
bindkey "^K" up-line-or-beginning-search
bindkey "^J" down-line-or-beginning-search

# Allow backspace to remove newlines
bindkey '^?' backward-delete-char

# vi mode tab completion
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'l' vi-forward-char

# get previous argument
bindkey -M viins '^O' copy-prev-shell-word

# vi mode
bindkey -v
KEYTIMEOUT=1

# Git branch name
function gitstatus() {
	exec 2>/dev/null
	ref=$(git rev-parse --abbrev-ref HEAD)
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
function vi-xclip {
	case $KEYS in
		y) zle vi-yank;;
		d) zle vi-delete;;
	esac
	echo "$CUTBUFFER" | xclip -r -sel clip
}
zle -N vi-xclip
bindkey -M vicmd 'y' vi-xclip
bindkey -M vicmd 'd' vi-xclip

# Edit line in editor
autoload edit-command-line; zle -N edit-command-line
bindkey '^E' edit-command-line

# Other config files
. $ZDOTDIR/.aliasrc
. $ZDOTDIR/.functions

# zsh-autosuggestions
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# Plugins
for file in $ZDOTDIR/plugins/*/*.plugin.zsh(N@,.); do
	. "$file"
done

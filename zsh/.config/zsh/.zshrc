# Change prompt
[[ $SSH_CONNECTION ]] && local uath='%F{green}%M%f '
PROMPT=$'${uath}%F{blue}%B%(7~|...%5~|%~)%f%b $(git-info)\n%F{green}%B➜%b%f '

# Options
setopt share_history hist_ignore_space hist_ignore_dups
setopt interactive_comments
setopt noflowcontrol
setopt complete_in_word
setopt prompt_subst
setopt globdots
setopt cd_silent
setopt extendedglob

# History
HISTFILE="$HOME/.zhistory"
HISTSIZE=100000
SAVEHIST=100000

# Completion
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*:default' menu yes select
zstyle ':completion:*' rehash true
autoload -U compinit; compinit
zmodload zsh/complist

# Ls colors
export LS_COLORS="$(<$XDG_CONFIG_HOME/zsh/.lscolors)"

# Z completion
fpath+=($ZDOTDIR/plugins/zsh-z)

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

# Remove entire words using C-W
bindkey "^W" backward-kill-word

# vi mode tab completion
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'l' vi-forward-char

# vi mode
bindkey -v
KEYTIMEOUT=1

# fzf
source /usr/share/fzf/key-bindings.zsh

# Git branch name
function git-info() {
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

# Yank to system clipboard
function vi-xclip {
	case $KEYS in
		y) zle vi-yank;;
		d) zle vi-delete;;
	esac
	echo "$CUTBUFFER" | tr -d "\n" | xclip -sel clip
}
zle -N vi-xclip
bindkey -M vicmd 'y' vi-xclip
bindkey -M vicmd 'd' vi-xclip

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

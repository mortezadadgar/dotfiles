# Enable Powerlevel10k instant prompt.
if [[ -r "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  . "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Options
setopt share_history hist_ignore_space hist_ignore_dups
setopt glob_complete glob_dots glob_star_short extended_glob
setopt nocomplete_aliases complete_in_word
setopt interactive_comments
setopt auto_pushd pushd_ignore_dups cd_silent
setopt noflowcontrol

# History
HISTFILE="$HOME/.zhistory"
HISTSIZE=100000
SAVEHIST=100000

# Completion
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zstyle ":completion:*:default" list-colors ${(s.:.)LS_COLORS} "ma=48;5;12;38;5;0"
zstyle ':completion:*:default' menu yes select
autoload -U compinit; compinit
zmodload zsh/complist

# up and down keys to search history
autoload up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# vi mode tab completion
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect '^[[Z' reverse-menu-complete

# vi mode
KEYTIMEOUT=1
bindkey -v

# misc
bindkey '^?' backward-delete-char
bindkey '^Q' push-line

# Change cursor shape for different vi modes
function zle-keymap-select() {
    case $KEYMAP in
        vicmd) print -n '\e[2 q';;      # block
        viins|main) print -n '\e[6 q';; # beam
    esac
}
zle -N zle-keymap-select

# Default cursor shape
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
    echo "$CUTBUFFER" | wl-copy -n
}
zle -N vi-clip
bindkey -M vicmd 'y' vi-clip
bindkey -M vicmd 'd' vi-clip

# Edit line in editor
autoload edit-command-line; zle -N edit-command-line
bindkey "^E" edit-command-line

# rehash on USR1 sig
TRAPUSR1() {
    rehash
}

# aliases
. $ZDOTDIR/aliasrc

# fzf
if (( $+commands[fzf] )); then
    . /usr/share/fzf/key-bindings.zsh
    . /usr/share/fzf/completion.zsh
fi

# lazy load nvm
nvm() {
    source "/usr/share/nvm/init-nvm.sh"
    nvm "$@"
}

# Plugins
. $ZDOTDIR/plugins/zsh-syntax-highlighting/*.plugin.zsh
. $ZDOTDIR/plugins/zsh-autosuggestions/*.plugin.zsh
. $ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme

# Render comments in bright black color
ZSH_HIGHLIGHT_STYLES[comment]="fg=8"

# load p10k config
. "$ZDOTDIR"/.p10k.zsh

# Enable colors and change prompt
autoload -U colors && colors
PS1=$'\n%(4~|%-1~/…/%3~|%~)\n%F{green}❯%f '
setopt interactive_comments
setopt noflowcontrol
setopt complete_in_word

# Completion configuration
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu yes select
autoload -U compinit; compinit
zmodload zsh/complist

# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=1200000
SAVEHIST=1000000

# cdr configuration
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 25

# Fuzzy find history forward/backward
autoload up-line-or-beginning-search
autoload down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# vi mode
bindkey -v
bindkey -v '^?' backward-delete-char
KEYTIMEOUT=5

# vi mode tab completion
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'l' vi-forward-char

# n^3
if command -v nnn > /dev/null; then
	source $HOME/.config/nnn/config
	bindkey -s '^N' 'n\n'
fi

# Source fzf bindings
if command -v fzf > /dev/null; then
	source /usr/share/fzf/key-bindings.zsh
fi

# ZLE hook for cursor modes
function zle-keymap-select zle-line-init {
case $KEYMAP in
	vicmd) echo -ne '\e[1 q';;      # block
	viins|main) echo -ne '\e[5 q';; # beam
esac
}
zle -N zle-line-init
zle -N zle-keymap-select

# Easily jump between previously visited directories
function fzf-cdr () {
  local dir=$(cdr -l | awk '{print $2}' | fzf -q "${LBUFFER}")
  if [ -n "${dir}" ]; then
    BUFFER="cd ${dir}"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N fzf-cdr
bindkey '^g' fzf-cdr

# Aliases
source $HOME/.aliasrc

# auto-suggestion configurations
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null

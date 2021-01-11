# Powerlevel10k instant prompt.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# configure zsh histroy
HISTFILE=$ZDOTDIR/histfile
HISTSIZE=1200000
SAVEHIST=1000000
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_expire_dups_first
setopt hist_verify

# zsh completion configuration
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select
zstyle ':completion:*:default' menu yes select
zstyle :compinstall filename '$ZDOTDIR/.zshrc'
_comp_options+=(globdots)
autoload -Uz compinit && compinit
zmodload zsh/complist

# misc
setopt interactivecomments
setopt noflowcontrol

# ZINIT Installer
source $ZDOTDIR/zinitrc

# need to be loaded as fast as possible
zinit snippet OMZ::lib/key-bindings.zsh
zinit ice depth=1 atload'source $ZDOTDIR/p10k.zsh'
zinit light romkatv/powerlevel10k

# wait"0" plugins
zinit wait lucid for \
    ael-code/zsh-colored-man-pages \
    urbainvaes/fzf-marks

# fast-syntax-highlighting, autosuggestions and completions
zinit wait lucid for \
    atinit'ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay' \
    zdharma/fast-syntax-highlighting \
    blockf \
    zsh-users/zsh-completions \
    atload'_zsh_autosuggest_start' \
    zsh-users/zsh-autosuggestions

# autosuggestions configuration
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# aliases
source $ZDOTDIR/aliasrc

# vi mode
bindkey -v
export KEYTIMEOUT=1

# fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
export FZF_DEFAULT_OPTS="
--color=dark
--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7"

# Use vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# n^3
source $HOME/.config/nnn/config
bindkey -s '^n' 'n\n'

# sudo the last entered command
bindkey -s '^s' 'sudo !!\n'

# WORKAROUND
# change cursor style to Beam/NVIM changing it back to block
_beam_cursor() {
    echo -ne '\e[6 q'
}
precmd_functions+=(_beam_cursor)

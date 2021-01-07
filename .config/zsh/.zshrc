# Powerlevel10k instant prompt.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# configure zsh histroy
HISTFILE=$ZDOTDIR/histfile
HISTSIZE=120000
SAVEHIST=100000
# share the zsh histroy across the terminal windows
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_expire_dups_first
setopt hist_verify

# zsh completion configuration
zstyle :compinstall filename '$ZDOTDIR/.zshrc'
autoload -Uz compinit && compinit
# required by fzf-tab
zstyle ":completion:*:git-checkout:*" sort false
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -1 --color=always $realpath'
zstyle ':completion:*files' ignored-patterns '*?.o' # Ignore *.o
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # case insensitive completion

# ZINIT Installer
source $ZDOTDIR/zinitrc

# set default editor
export SUDO_EDITOR=/usr/bin/nvim
export EDITOR=nvim

# always clear screen after exiting ls
export LESS=R

# use all cpu cores for compilation
export MAKEFLAGS="-j$(nproc)"

# GO
export GOPATH=$HOME/scripts/Go
export GOBIN=$HOME/scripts/Go/bin

# colorize go test
go_test() {
  go test $* | sed ''/PASS/s//$(printf "\033[32mPASS\033[0m")/'' | \
      sed ''/SKIP/s//$(printf "\033[34mSKIP\033[0m")/'' | \
      sed ''/FAIL/s//$(printf "\033[31mFAIL\033[0m")/'' | \
      sed ''/FAIL/s//$(printf "\033[31mFAIL\033[0m")/'' | \
      GREP_COLOR="01;33" egrep --color=always '\s*[a-zA-Z0-9\-_.]+[:][0-9]+[:]|^'
}

# need to be loaded as fast as possible
zinit snippet OMZ::lib/key-bindings.zsh
zinit ice depth=1 atload'source $ZDOTDIR/p10k.zsh'
zinit light romkatv/powerlevel10k

# wait"0" plugins
zinit wait lucid for \
    ael-code/zsh-colored-man-pages \
    atload'zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS}' \
    Aloxaf/fzf-tab \
    urbainvaes/fzf-marks

# wait"1" plugins
zinit wait"1" lucid for \
    OMZ::plugins/archlinux/archlinux.plugin.zsh \
    OMZ::plugins/systemd/systemd.plugin.zsh \
    OMZ::plugins/git/git.plugin.zsh \
    kutsan/zsh-system-clipboard \
    from'gh-r' as'program' mv'vivid* -> vivid' pick'vivid/vivid' \
    atload'export LS_COLORS="$(vivid generate $HOME/.config/one-dark.yml)"' \
    @sharkdp/vivid

# wait"2" plugins
zinit wait"2" lucid for \
    from'gh-r' as'program' mv'dust* -> dust' pick'dust/dust' \
    bootandy/dust

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
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# aliases
source $ZDOTDIR/aliasrc

# vi mode
# NOTE: Should be configured before fzf
bindkey -v
export KEYTIMEOUT=1

# fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
export FZF_DEFAULT_COMMAND="fd --type f --follow"
export FZF_CTRL_T_COMMAND="fd --type f --follow"
export FZF_ALT_C_COMMAND="fd --type d --follow"
export FZF_DEFAULT_OPTS="
--color=dark
--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7"

# n^3
source $HOME/.config/nnn/config
bindkey -s '^n' 'n\n'

# override the clear the screen command
bindkey -s '^l' 'clear\n'

# sudo the last entered command
bindkey -s '^s' 'sudo !!\n'

# misc
setopt interactivecomments
setopt noflowcontrol
_comp_options+=(globdots)

# P10K extra customizations
# Disable P10K reporting exit codes
typeset -g POWERLEVEL9K_STATUS_EXTENDED_STATES=false

# same green color on last command failed
typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=76

# change default cursor shape to Beam
echo -ne '\e[6 q'
_fix_cursor() {
    echo -ne '\e[6 q'
}
precmd_functions+=(_fix_cursor)

# Bat
export BAT_THEME="ansi-dark"

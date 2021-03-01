# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Prompt theme
ZSH_THEME="refined"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Disable marking untracked files
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Plugins
plugins=(archlinux colored-man-pages git systemd vi-mode zsh_reload)

# LS_COLORS
export LS_COLORS="$(vivid generate $HOME/.config/one-dark.yml)"

source $ZSH/oh-my-zsh.sh

# colored man pages
less_termcap[md]="${fg_bold[blue]}"
less_termcap[so]="${fg_bold[black]}${bg[white]}"

# Vi mode
VI_MODE_SET_CURSOR=true
export KEYTIMEOUT=18

# ZSH completion
autoload -U compinit && compinit
zmodload zsh/complist
zstyle ':completion:*:default' menu yes select

# User configuration
export EDITOR=nvim
export BROWSER=firefox
export LESS="-x4R"
export MAKEFLAGS="-j$(nproc)"
export GOPATH=$HOME/scripts/Go
export GOBIN=$HOME/scripts/Go/bin

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

# Aliases
alias ls='ls -Nh --color=auto --group-directories-first'
alias pacman='pacman --color=auto'
alias grep='grep --color=auto'
alias mkdir='mkdir --parents'
alias yay='yay --color=auto'
alias sudo='sudo -v; sudo '
alias svi='sudoedit'
alias nf='neofetch'
alias n='nnn -uex'
alias du='du -h'
alias cl='clear'
alias vi='nvim'
alias ht='htop'

# Autosuggestions configuration
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source /usr/share/fzf-marks/fzf-marks.zsh

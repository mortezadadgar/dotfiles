# Prompt
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[green]%}λ %{$fg[blue]%}%(4~|%-1~/…/%3~|%~)%{$fg[red]%}]%{$reset_color%}%b "
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{13}[%b]'

# configure zsh histroy
HISTFILE=~/.histfile
HISTSIZE=120000
SAVEHIST=100000
# share the zsh histroy across the terminal windows
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_expire_dups_first
setopt hist_verify

# zsh completion configuration
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit && compinit
_comp_options+=(globdots)		# Include hidden files.
# required by fzf-tab
zstyle ":completion:*:git-checkout:*" sort false
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -1 --color=always $realpath'
zstyle ':completion:*files' ignored-patterns '*?.o' # Ignore *.o
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # case insensitive completion

# ZINIT Installer
source $HOME/.zinitrc

# set default editor
export SUDO_EDITOR=/usr/bin/nvim
export EDITOR=nvim

# always clear screen after exiting ls
export LESS=R

# GO
export GOPATH=$HOME/scripts/Go
export GOBIN=$HOME/scripts/Go/bin

# need to be loaded as fast as possible
zinit snippet OMZ::lib/key-bindings.zsh
zinit snippet OMZ::lib/termsupport.zsh

# ls colors
zinit pack for ls_colors

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
    OMZ::plugins/golang/golang.plugin.zsh

# wait"2" plugins
zinit wait"2" lucid for \
    OMZ::plugins/sudo/sudo.plugin.zsh

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
source $HOME/.aliasrc

# fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
export FZF_DEFAULT_OPTS="--ansi"
export FZF_CTRL_T_COMMAND="fd --type f --follow --color=always"
export FZF_ALT_C_COMMAND="fd --type d --follow --color=always"
export FZF_ALT_C_OPTS="--preview 'ls -1 --color=always {}'"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7'

# n^3
source ~/.nnn
bindkey -s '^n' 'n\n'

# override the clear the screen command
bindkey -s '^l' 'clear\n'

# misc
setopt interactivecomments
setopt noflowcontrol

# terminal title
export ZSH_THEME_TERM_TITLE_IDLE='zsh: %~'

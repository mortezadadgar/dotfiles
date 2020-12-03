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
HISTSIZE=100000
SAVEHIST=100000
# share the zsh histroy across the terminal windows
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify

# zsh completion configuration
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit && compinit
_comp_options+=(globdots)		# Include hidden files.
# required by fzf-tab
zstyle ":completion:*:git-checkout:*" sort false
# zstyle ':completion:*:descriptions' format brief
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -1 --color=always $realpath'
zstyle ':fzf-tab:complete:(cat|nvim):*' fzf-preview 'bat --style=numbers --color=always --line-range :200 $realpath'
zstyle ':completion:*files' ignored-patterns '*?.o' # Ignore *.o
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # case insensitive completion

# ZINIT Installer
source $HOME/.zinitrc

# set default editor
export SUDO_EDITOR=/usr/bin/nvim
export EDITOR=nvim

# always clear screen after exiting ls
export LESS=R

# need to be loaded as fast as possible
zinit snippet OMZ::lib/key-bindings.zsh

# ls colors
zinit pack for ls_colors

# wait "1" plugins
zinit wait"1" lucid for \
    OMZ::plugins/archlinux/archlinux.plugin.zsh \
    OMZ::plugins/systemd/systemd.plugin.zsh \
    OMZ::plugins/git/git.plugin.zsh \
    Aloxaf/fzf-tab

# wait "2" plugins
zinit wait"2" lucid for \
    OMZ::plugins/sudo/sudo.plugin.zsh

# fast-syntax-highlighting, autosuggestions and completions
zinit wait lucid for \
	atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
	    zdharma/fast-syntax-highlighting \
	blockf \
	    zsh-users/zsh-completions \
	atload"!_zsh_autosuggest_start" \
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
export FZF_CTRL_T_COMMAND="fd --type f --follow"
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :200 {}'"
export FZF_ALT_C_COMMAND="fd --type d --follow"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7'

# NNN
source ~/.nnn
bindkey -s '^n' 'n\n'

# Bat
export BAT_THEME="ansi-dark"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

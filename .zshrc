# Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# configure zsh histroy
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt share_history # share the zsh histroy across the terminal windows
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify

# zsh completion configurations
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit && compinit
zmodload zsh/complist
_comp_options+=(globdots)		# Include hidden files.
zstyle ':completion:*:descriptions' format brief
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -1 --color=always $realpath'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:*:default' menu yes select search
zstyle ':completion:*files' ignored-patterns '*?.o' # Ignore *.o
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path $ZSH_CACHE_DIR
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' # case insensitive completion

# ZINIT Installer
source $HOME/.zinitrc

# set default editor
export SUDO_EDITOR=/usr/bin/nvim
export EDITOR=nvim

# always clear screen after exiting ls
export LESS=R

# powerlevel10k
zinit ice depth=1 atload"!source ~/.p10k.zsh" nocd
zinit light romkatv/powerlevel10k

# need to be loaded as fast as possible
zinit snippet OMZ::lib/key-bindings.zsh
zinit snippet OMZ::plugins/git/git.plugin.zsh

# wait "1" plugins
zinit wait"1" lucid for \
    OMZ::plugins/archlinux/archlinux.plugin.zsh \
    OMZ::plugins/systemd/systemd.plugin.zsh \
    OMZ::plugins/sudo/sudo.plugin.zsh

# fast-syntax-highlighting, autosuggestions and completions
zinit wait lucid for \
	atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
	    zdharma/fast-syntax-highlighting \
	blockf \
	    zsh-users/zsh-completions \
	atload"!_zsh_autosuggest_start" \
	    zsh-users/zsh-autosuggestions

# ls colors
zinit pack for ls_colors

# fzf-tab
zinit ice wait lucid
zinit load Aloxaf/fzf-tab

# aliases
source $HOME/.aliasrc

# fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
export FZF_CTRL_T_COMMAND="fd --type f --follow"
export FZF_ALT_C_COMMAND="fd --type d --follow"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7'

# NNN
source ~/.nnn

# P10K extra customizations
typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE='%n'
typeset -g POWERLEVEL9K_STATUS_EXTENDED_STATES=false
unset POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}_{CONTENT,VISUAL_IDENTIFIER}_EXPANSION

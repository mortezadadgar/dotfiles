# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit

# End of lines added by compinstall

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

# set default sudoeditor
export SUDO_EDITOR=/usr/bin/nvim
# set nvim as default
export EDITOR=nvim

# powerlevel10k
zinit ice depth=1 atload"!source ~/.p10k.zsh" lucid nocd
zplugin light romkatv/powerlevel10k

# o-my-zsh
# key-binding
# always load fzf after key-bindings
zinit ice wait atload"!source /usr/share/fzf/key-bindings.zsh !source /usr/share/fzf/completion.zsh" lucid nocd
zinit snippet OMZ::lib/key-bindings.zsh
# git
zinit ice wait lucid
zinit snippet OMZ::plugins/git/git.plugin.zsh
# archlinux yarem,yain...
zinit ice wait"1" lucid
zinit snippet OMZ::plugins/archlinux/archlinux.plugin.zsh
# systemd
zinit ice wait"2" lucid
zinit snippet OMZ::plugins/systemd/systemd.plugin.zsh
# colored man-pages
zinit ice wait"3" lucid
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
# double esc
zinit ice wait"3" lucid
zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh

# completion color
zinit wait"0c" lucid reset \
 atclone"local P=${${(M)OSTYPE:#*darwin*}:+g}
        \${P}sed -i \
        '/DIR/c\DIR 38;5;63;1' LS_COLORS; \
        \${P}dircolors -b LS_COLORS > c.zsh" \
 atpull'%atclone' pick"c.zsh" nocompile'!' \
 atload'zstyle ":completion:*:default" list-colors "${(s.:.)LS_COLORS}";' for \
    trapd00r/LS_COLORS

# completion zstyle
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always
zstyle ":completion:*:descriptions" format "%B%d%b"
zstyle ':completion:*:*:*:default' menu yes select search
zstyle ':completion:*files' ignored-patterns '*?.o'
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path $ZSH_CACHE_DIR

# alias
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias pacman='pacman --color=auto'
alias yay='yay --color=auto'
alias ht='htop'
alias ll='ls -lh'
alias vi='nvim'
alias rf='sudo reflector --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist &'
alias svi='sudoedit'
alias sudo='sudo -v; sudo '
alias pt='sudo powertop'
alias mkdef='make shadow_defconfig; cp .config arch/arm64/configs/shadow_defconfig'
alias rr='ranger'
alias pacorph='sudo pacman -Rns $(pacman -Qtdq)'
alias kaa='sudo killall'
alias cl='clear'
alias nf='neofetch'
alias bsf='bash -xc '\''bspc rule -a $0 state=floating'\'''
alias gbb='git branch | fzf | xargs git checkout'
alias rm='rm -f'
alias rg='rg --smart-case'
alias inmea='sudo intel-undervolt measure'
alias grevn='git revert --no-edit'

function take() {
  mkdir -p $@ && cd ${@:$#}
}

# copy contents of a file to clipboard
function xcp() {
  cat $1 |xclip -selection clipboard
}

# preserve history for new instance
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

# fzf
export FZF_DEFAULT_COMMAND="fd --type f -H"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d -H"

# fast-syntax and autosuggestions
zinit wait lucid for \
	 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
	     zdharma/fast-syntax-highlighting \
	      blockf \
	          zsh-users/zsh-completions \
		   atload"!_zsh_autosuggest_start" \
		       zsh-users/zsh-autosuggestions


# Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# configure zsh histroy
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

# configure zsh compinit
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
compinit

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

# Annexes
zinit light-mode for \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

# set default sudoeditor
export SUDO_EDITOR=/usr/bin/nvim
# set nvim as default
export EDITOR=nvim
# always clear screen after exit ls
export LESS=R

# powerlevel10k
zinit ice depth=1 atload"!source ~/.p10k.zsh" lucid nocd
zinit light romkatv/powerlevel10k

# o-my-zsh
# key-binding
# always load fzf-bindings after key-bindings
zinit ice \
	 atload"!source /usr/share/fzf/key-bindings.zsh \
	 !source /usr/share/fzf/completion.zsh"
zinit snippet OMZ::lib/key-bindings.zsh
# git
zinit ice wait lucid
zinit snippet OMZ::plugins/git/git.plugin.zsh
# archlinux yarem,yain...
zinit ice wait"1" lucid
zinit snippet OMZ::plugins/archlinux/archlinux.plugin.zsh
# systemd
zinit ice wait"1" lucid
zinit snippet OMZ::plugins/systemd/systemd.plugin.zsh
# double esc
zinit ice wait"3" lucid
zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh

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

# completion zstyle
zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*:descriptions' format brief
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -1 --color=always $realpath'
zstyle ':completion:*files' ignored-patterns '*?.o'
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path $ZSH_CACHE_DIR
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# alias
alias ls='ls -h --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias pacman='pacman --color=auto'
alias yay='yay --color=auto'
alias ht='htop'
alias ll='ls -lh --color=auto --group-directories-first'
alias vi='nvim'
alias rf='sudo reflector --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist &'
alias svi='sudoedit'
alias sudo='sudo -v; sudo '
alias pt='sudo powertop'
alias mkdef='make shadow_defconfig; cp .config arch/arm64/configs/shadow_defconfig'
alias pacorph='sudo pacman -Rns $(pacman -Qtdq)'
alias cl='clear'
alias nf='neofetch'
alias inmea='sudo intel-undervolt measure'
alias grevn='git revert --no-edit'
alias glg='git log --no-merges'
alias gcps='git cherry-pick --skip'
alias gams='git commit --amend -s'
alias pc='sudo picocom -b 115200 /dev/ttyUSB0'
alias sxiv='sxiv-rifle'

# preserve history for new instance
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

# fzf
export FZF_CTRL_T_COMMAND="fd --type f --follow"
export FZF_ALT_C_COMMAND="fd --type d --follow"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7'

# NNN
source ~/.nnn

# Jump
eval "$(jump shell --bind=j)"

# P10K extra customizations
typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE='%n'
typeset -g POWERLEVEL9K_STATUS_EXTENDED_STATES=false
unset POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}_{CONTENT,VISUAL_IDENTIFIER}_EXPANSION

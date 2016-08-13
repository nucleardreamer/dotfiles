#!/bin/zsh

export EDITOR="nano"
export BROWSER="google-chrome-stable"

export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"

setopt always_to_end list_types  # completion

setopt extendedglob hist_expire_dups_first hist_ignore_all_dups hist_ignore_space hist_verify share_history  # history
HISTSIZE=2000
SAVEHIST=10000
HISTFILE=~/.zsh_history

setopt check_jobs interactive_comments rcquotes transient_rprompt

autoload -Uz compinit
compinit
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
# zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
# zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

autoload -U colors && colors
autoload -Uz vcs_info
setopt prompt_subst

#bindkey '\e[A' history-beginning-search-backward
#bindkey '\e[B' history-beginning-search-forward

#source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

if [ $SSH_CLIENT ]; then
    DOMAIN='%F{red}%m'
else
    DOMAIN='%m'
fi
PROMPT='%B%(!.%F{red}.%F{green})%n@$DOMAIN%F{white}%b:%B%F{blue}%~%f${vcs_info_msg_0_}%f %F{cyan}${VIRTUAL_ENV:t}%b%f
> '
RPROMPT=''



[[ -e ~/.zsh_aliases ]] && source ~/.zsh_aliases

export NVM_DIR="/home/nuclear/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

[ -z "$DISPLAY" -a "$(fgconsole)" -eq 1 ] && exec startx

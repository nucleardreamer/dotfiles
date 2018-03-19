export TERM="xterm-256color"

export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin:$HOME/bin"
export VISUAM="nano"

export ANDROID_HOME=/opt/android-sdk

source ~/.zsh_aliases

export ZSH=/home/chronic/.oh-my-zsh

ZSH_THEME="blinks"

plugins=(git archlinux docker last-working-dir wd)

source $ZSH/oh-my-zsh.sh

bindkey '[C' forward-word
bindkey '[D' backward-word

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

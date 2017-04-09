export TERM="xterm-256color"

export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin:$HOME/bin"

export ANDROID_HOME=/opt/android-sdk

source ~/.zsh_aliases

export ZSH=/home/chronic/.oh-my-zsh

ZSH_THEME="avit"
plugins=(git)

source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

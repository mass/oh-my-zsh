# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Oh my zsh configuration
ZSH=$HOME/.dotfiles/zsh
ZSH_THEME="mass"
plugins=(git git-prompt npm mvn)
source $ZSH/oh-my-zsh.sh
export PATH=$HOME/bin:/usr/local/bin:$PATH

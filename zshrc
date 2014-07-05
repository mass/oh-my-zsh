# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Oh my zsh configuration
ZSH=$HOME/.dotfiles/zsh
ZSH_THEME="mass"

DISABLE_AUTO_UPDATE="true"

# Plugins
plugins=()
plugins+=(colored-man)
plugins+=(common-aliases)
plugins+=(git-extras)
plugins+=(git-prompt)
plugins+=(mvn)
plugins+=(sublime)
plugins+=(svn)
plugins+=(zsh-syntax-highlighting)

# Activate
source $ZSH/oh-my-zsh.sh
export PATH=$HOME/bin:/usr/local/bin:$PATH

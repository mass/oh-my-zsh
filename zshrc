# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Oh my zsh configuration
ZSH=$HOME/.dotfiles/zsh
ZSH_THEME="mass"

DISABLE_AUTO_UPDATE="true"

# Plugins
plugins=()
plugins+=(fasd)
plugins+=(git-prompt)
plugins+=(zsh-syntax-highlighting)
plugins+=(zsh-autosuggestions)
plugins+=(zsh-completions)

# Activate
source $ZSH/oh-my-zsh.sh
export PATH=$HOME/bin:/usr/local/bin:$PATH

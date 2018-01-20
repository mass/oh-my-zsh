############################
# Custom ZSH Configuration #
#                          #
# Author: Andrew Mass      #
# Date:   2014-07-30       #
############################

# Shell options
setopt AUTO_CD
setopt CHASE_LINKS
setopt EXTENDED_GLOB
setopt HIST_FIND_NO_DUPS
setopt NO_CHECK_JOBS
setopt NO_HUP
setopt SHORT_LOOPS
unsetopt COMPLETE_ALIASES
unsetopt BEEP
unsetopt HIST_BEEP
unsetopt LIST_BEEP

# Color variables
BOLD="$(tput bold)"
RED=$BOLD"$(tput setaf 1)"
GREEN=$BOLD"$(tput setaf 2)"
YELLOW=$BOLD"$(tput setaf 3)"
BLUE=$BOLD"$(tput setaf 4)"
PURPLE=$BOLD"$(tput setaf 5)"
CYAN=$BOLD"$(tput setaf 6)"
WHITE=$BOLD"$(tput setaf 7)"
RESET="$(tput sgr0)"

## Completions
autoload -U compinit
compinit -C
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Make .zsh_history store more and not store duplicates
export HISTCONTROL=ignoreboth
export HISTSIZE=100000
export HISTFILESIZE=100000

# Key bindings
bindkey '^R' history-incremental-search-backward

# Command Aliases
alias a='alias'
alias m="man"
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias more="less" # Less is more
alias diff="diff -s"
alias grep='grep --color=auto'
alias tmuxa="tmux attach-session -t"
alias tmuxl="tmux list-sessions"
alias j="fasd_cd -d"
alias open="xdg-open"
alias g="git"
alias tigs="tig status"
alias tigy="tig stash"

# Util Aliases
alias copy="xclip -selection clipboard"
alias profileme="history | awk '{print \$2}' | awk 'BEGIN {FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 30 | sort -rn"
alias speedtest="wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip"
alias shell='ps -p $$ -o comm='
alias valgrind-leak='valgrind --leak-check=full --show-reachable=yes'
alias sensors="watch -d -n 0.5 sensors"
alias redreset="redshift -x"

# ls aliases
alias sl="ls"
alias la="ls -A"
alias ll="ls -lh"
alias lla="ll -A"
alias l1="ls -1"
alias l1a="l1 -A"
alias l="ls"
alias ls='ls --color=auto'

# Configuration aliases
alias bashrc="vim ~/.bashrc"
alias zshrc="vim ~/.dotfiles/zsh/custom/mass.zsh"
alias vimrc="vim ~/.vimrc"
alias zshtheme="vim ~/.dotfiles/zsh/custom/mass.zsh-theme"
alias shload="exec zsh"

# Useful environment variables
export EDITOR=vim
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/site-packages

# Randomness functions
flipcoin() {
  [[ $((RANDOM % 2)) == 0 ]] && echo TAILS || echo HEADS
}
rolldie() {
  if [[ -n "$1" ]]; then
    SIDES="$1"
  else
    SIDES=6
  fi
  echo $((RANDOM % $SIDES))
}
randgen() {
  if [[ $# -eq 0 ]]; then
    openssl rand -hex 32
  else
    openssl rand -hex $1 | cut -c1-$1
  fi
}

# Travels up N directories
up() {
  if [[ $# -eq 0 ]]; then
    local NUM=1
  else
    local NUM=$1
  fi

  local DIR=$PWD

  for ((i=0; i<NUM; i++)) do
    DIR=$DIR/..
  done

  cd $DIR
}

# Manual Package Update and Cleaning
pkupdate() {
  # Run everything as root
  sudo echo ""

  Time="$(date +%s)"
  echo -e "${GREEN}Starting Package Update${RESET}"
  echo -e "${GREEN}=======================${RESET}"

  if [[ $# -gt 0 ]]; then
    echo -e "${CYAN}Arguments: $@${RESET}"
  fi

  # Use apt-get if present
  local APT_GET_VERSION=$(apt-get --version 2> /dev/null)
  if [[ "${APT_GET_VERSION}" ]]; then
      echo -e "${GREEN}\nUsing apt-get!${RESET}"
      echo -e "${GREEN}--------------${RESET}"

      echo -e "${GREEN}\nUpdating Repositories${RESET}"
      sudo apt-get $@ update

      echo -e "${GREEN}\nUpdating Packages${RESET}"
      sudo apt-get $@ upgrade

      echo -e "${GREEN}\nUpdating Distribution Packages${RESET}"
      sudo apt-get $@ dist-upgrade

      echo -e "${GREEN}\nChecking and Repairing Dependencies${RESET}"
      sudo apt-get $@ check

      echo -e "${GREEN}\nRemoving Unnecessary Packages${RESET}"
      sudo apt-get $@ autoremove --purge

      echo -e "${GREEN}\nCleaning Package Download Files${RESET}"
      sudo apt-get $@ autoclean
      sudo apt-get $@ clean
  fi

  # Use pacman if present
  local PACMAN_VERSION=$(pacman --version 2> /dev/null)
  if [[ "${PACMAN_VERSION}" ]]; then
      echo -e "${GREEN}\nUsing pacman!${RESET}"
      echo -e "${GREEN}-------------${RESET}"

      echo -e "${GREEN}\nUpdating Package Databases${RESET}"
      sudo pacman -Syy $@

      echo -e "${GREEN}\nUpdating Packages${RESET}"
      sudo pacman -Suu --needed $@

      echo -e "${GREEN}\nRemove Unnecessary Packages${RESET}"
      local UP=$(pacman -Qtdq)
      if [[ "${UP}" ]]; then
          pacman -Qtdq | sudo pacman -Rnssu -
      fi

      echo -e "${GREEN}\nCleaning Caches${RESET}"
      sudo pacman -Scc $@ <<< Y <<< Y

      echo -e "${GREEN}\nCheck Database Consistency${RESET}"
      pacman -Dk
      pacman -Dkk

      echo -e "${GREEN}\nCheck Package Integrity${RESET}"
      sudo pacman -Qk --color=always | grep "warning: "

      echo -e "${GREEN}\nOptional Commands:${RESET}"
      echo -e "sudo pacman -Qkk      : More detailed package integrity checks"
      echo -e "sudo pacman-optimize  : Defragment package database files"
  fi

  local YAOURT_VERSION=$(yaourt --version 2> /dev/null)
  if [[ "${YAOURT_VERSION}" ]]; then
    echo -e "${GREEN}\nUsing yaourt!${RESET}"
    echo -e "${GREEN}-------------${RESET}"
    yaourt -Syu --aur
  fi

  Time="$(($(date +%s) - Time))"
  echo -e "${GREEN}\nPackage Update Complete. Time Elapsed: ${RED}${Time}s${RESET}"
}

# Remind me of common maitenance commands
remind() {
    echo -e "pkupdate            : Perform package maitenance"
    echo -e "systemctl --failed  : Check systemd failed units"
    echo -e "journalctl -xb -p 3 : Check systemd logs"
    echo -e "pacman -Qte         : Review manually installed, unrequired packages"
    echo -e "pacgraph            : Generate visual representation of packages"
}

# Directory usage stats
dstat() {
  local DIR=$(pwd)
  [ ! -z "$1" ] && DIR="$1"
  du $DIR -h -d 1 | sort -hr
}

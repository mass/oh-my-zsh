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
GREEN=$BOLD"$(tput setaf 2)"
RED=$BOLD"$(tput setaf 1)"
BLUE=$BOLD"$(tput setaf 6)"
RESET="$(tput sgr0)"

## Completions
autoload -U compinit
compinit -C
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Key bindings
bindkey '^R' history-incremental-search-backward
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# ls aliases
alias sl="ls"
alias la="ls -A"
alias ll="ls -lh"
alias lla="ll -A"
alias l1="ls -1"
alias l1a="l1 -A"
alias l="ls"

# Configuration aliases
alias zshrc="vim ~/.zshrc"
alias bashrc="vim ~/.bashrc"
alias shload="exec zsh"
alias vimrc="vim ~/.vimrc"

# Git aliases
alias tigs="tig status"
alias amend="git commit --amend"
alias commit="git commit"
alias pull="git pull"
alias g="git"
alias ga="git add --all"
alias gc="git commit --verbose"
alias gco="git checkout"
alias gst="git status -sb"
alias gd="git diff"
alias gwc="git whatchanged -p --abbrev-commit --pretty=medium"
groot() {
  local groot_dir="$(git rev-parse --show-toplevel)"
  [[ -n ${groot_dir} ]] && cd groot_dir > /dev/null
}

# Miscellaneous aliases
alias more="less"
alias dirstat="du -d 1 -h | sort -hr | head -n 11"
alias ip="ifconfig | grep 'inet '"
alias copy="xclip -selection clipboard"
alias m="man"

# Linux specific
if [[ $(uname) = 'Linux' ]]; then
  alias open="xdg-open"
fi

# OSX specific
if [[ $(uname) = 'Darwin' ]]; then
  alias top="top -o cpu"
  alias sort="gsort"
fi

# Encryption functions
ssl_encrypt() {
  openssl aes-256-cbc -a -salt -in $1 -out $2
}
ssl_decrypt() {
  openssl aes-256-cbc -a -d -in $1 -out $2
}

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

# Fun bit of information
alias profileme="history | awk '{print \$2}' | awk 'BEGIN {FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 30 | sort -rn"

# Useful environment variables
export EDITOR=vim
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/site-packages

# Change terminal title
title() {
  echo -n -e "\033]0;$1\007"
}
title "zsh"

# Given an input n, gives a random string of length n.
# If no input supplied, generates a 64 character string.
randgen() {
  if [[ $# -eq 0 ]]; then
    openssl rand -hex 32
  else
    openssl rand -hex $1 | cut -c1-$1
  fi
}

# Speedtest alias
alias speedtest="wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip"

# Manual Package Update and Cleaning
pkupdate() {
  # Run everything as root
  sudo echo ""

  Time="$(date +%s)"
  echo -e "${GREEN}Starting Package Update${RESET}"
  echo -e "${GREEN}=======================${RESET}"

  if [[ $# -gt 0 ]]; then
    echo -e "${BLUE}Arguments: $@${RESET}"
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

# Pull every git directory in the pwd.
pull_with_report() {
  local dir
  dir="$1"
  if [[ -d $1/.git ]]; then
    echo $(echo $dir | sed 's/.|\///g') >&2
  fi
  out=`git --git-dir=$1/.git --work-tree=$PWD/$1 pull 2>/dev/null`
  if [[ -n $(echo $out | grep "Already up-to-date") ]]; then
    echo "--- $dir: no changes." >&2
  elif [[ -n $out ]]; then
    echo "+++ $dir: pulled changes." >&2
  fi
}

pulls() {
  $(
  local dirs
  for dir in */; do
    pull_with_report "$dir" > /dev/null &
  done
  wait
  )
}

# Remind me of common maitenance commands
remind() {
    echo -e "pkupdate            : Perform package maitenance"
    echo -e "systemctl --failed  : Check systemd failed units"
    echo -e "journalctl -xb -p 3 : Check systemd logs"
    echo -e "pacman -Qte         : Review manually installed, unrequired packages"
    echo -e "pacgraph            : Generate visual representation of packages"
}

# Define Color Variables for later usage
c_red=$(tput setaf 1)
c_green=$(tput setaf 2)
c_yellow=$(tput setaf 3)
c_blue=$(tput setaf 4)
c_purple=$(tput setaf 5)
c_cyan=$(tput setaf 6)
c_white=$(tput setaf 7)
c_reset=$(tput sgr0)

# Make .zsh_history store more and not store duplicates
export HISTCONTROL=ignoreboth
export HISTSIZE=100000
export HISTFILESIZE=100000

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe.sh ] && export LESSOPEN="|/usr/bin/lesspipe.sh %s"

# General aliases
alias hidden='ls -a | grep "^\..*"'
alias shell='ps -p $$ -o comm='
alias a='alias'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# C Aliases
alias cc='gcc -Wall -W -ansi -pedantic -O2 '
alias valgrind-leak='valgrind --leak-check=full --show-reachable=yes'

# Enable color support of ls and also add handy aliases
if [[ `uname` = 'Darwin' ]]; then
  alias ls='ls -G'
else
  alias ls='ls --color=auto'
fi
alias grep='grep --color=auto'

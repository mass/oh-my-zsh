############################
# Custom ZSH Configuration #
#                          #
# Author: Andrew Mass      #
# Date:   2014-07-30       #
############################

# General Aliases
alias diff="diff -s"
alias sensors="watch -d -n 1 sensors"
alias zshconfig="vim ~/.dotfiles/zsh/custom/mass.zsh"
alias zshtheme="vim ~/.dotfiles/zsh/custom/mass.zsh-theme"
alias j="fasd_cd -d"
alias tmuxa="tmux attach-session -t"
alias tmuxl="tmux list-sessions"

# More Git Aliases
alias gpl="git pull"
alias grb="git pull --rebase"
alias gpu="git push origin"
alias glg="git log"
alias gpom="git push origin master"

# Development Settings
export MAVEN_OPTS="-Xmx1024m -XX:MaxPermSize=1024m"
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk/bin/java"

# Prints a very pretty message
# Run 'yes $(prettyprint)' for a good time
prettyprint() {
  if [[ $# -eq 0 ]]; then
    local MSG="Unix is Pretty"
  else
    local MSG=$1
  fi

  toilet -f mono12 --gay $MSG
}

# Backs up all the important files in my home directory
backuphome() {
  if [[ $# -eq 0 ]]; then
    local DIR_BACKUP="/home/mass/Dropbox/backups/ubuntu"
  else
    local DIR_BACKUP=$(readlink -m $1)
  fi

  local DIR_TIME="$(date +%F)"
  if [ -d ~/$DIR_TIME ]; then
    echo "Error. Directory ~/$DIR_TIME already exists."
    kill -INT $$
  fi

  local DIR_OLD=$(pwd)
  T="$(date +%s)"
  echo "Starting backup of files\n\n"
  cd ~
  mkdir $DIR_TIME
  cd ./$DIR_TIME
  cp -rv ~/development ~/Downloads ~/.ssh ~/.nvidia-settings-rc .unity.profile ./
  cd ../
  tar cvzf "Compressed-Archive-"$(date +%F).tar.gz ./$DIR_TIME/
  rm -rf ./$DIR_TIME
  mv "Compressed-Archive-"$(date +%F).tar.gz $DIR_BACKUP
  cd $DIR_OLD
  T="$(($(date +%s)-T))"
  echo "\n\nBackup completed, time elapsed: ${T}"
}

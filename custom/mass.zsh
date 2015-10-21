############################
# Custom ZSH Configuration #
#                          #
# Author: Andrew Mass      #
# Date:   2014-07-30       #
############################

# General Aliases
alias diff="diff -s"
alias cpuinfo="sudo i7z_64bit"
alias sensors="watch -d -n 1 sensors"
alias svnup="svn up"
alias svndf="svn diff | less"
alias zshconfig="vim ~/.dotfiles/zsh/custom/mass.zsh"
alias zshtheme="vim ~/.dotfiles/zsh/custom/mass.zsh-theme"

# Directory Aliases
alias pegasus="cd /home/mass/development/web/pegasus"
alias mass-web="cd /home/mass/development/web/mass-web"
alias uiuc="cd /home/mass/Dropbox/dev/uiuc/"

# School Aliases
alias spim="QtSpim"
alias spimbot="QtSpimbot"
alias monad="../monad/monad --provided"
alias 391-devel="qemu-system-i386 -hda /home/mass/development/workdir-391/vm/devel.qcow \
    -m 1024 -name devel -net nic -net user,smb=/home/mass/development/workdir-391"
alias 391-nodebug="qemu-system-i386 -m 512 -name test \
    -hda /home/mass/development/workdir-391/ece391mp/student-distrib/mp3.img"
alias 391-debug="qemu-system-i386 -m 512 -name test -gdb tcp:127.0.0.1:1234 -S \
    -hda /home/mass/development/workdir-391/ece391mp/student-distrib/mp3.img"

# More Git Aliases
alias gpl="git pull"
alias grb="git pull --rebase"
alias gpu="git push origin"
alias glg="git log"
alias gpom="git push origin master"

# Pegasus Aliases
alias pegasus-db="mysql -u root pegasus"
alias pgssh="ssh-add ~/.ssh/pegasus-prod.pem;ssh"

# Development Settings
export PATH=${PATH}:~/Dropbox/dev/android/android-sdk-linux/tools:~/Dropbox/dev/android/android-sdk-linux/platform-tools
export MAVEN_OPTS="-Xmx1024m -XX:MaxPermSize=1024m"

export TERM=xterm-256color

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

# Clean and refresh the local pegasus database
refresh-pegasus-db() {
  local OLD_DIR=$(pwd)
  cd ~/development/web/pegasus/tools
  cat create_tables.sql create_testdata.sql | mysql -u root pegasus
  cd $OLD_DIR
}

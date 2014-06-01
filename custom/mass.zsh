############################
# Custom ZSH Configuration #
#                          #
# Author: Andrew Mass      #
# Date:   2014-06-01       #
############################

# General Aliases
alias diff="diff -s"
alias cpuinfo="sudo i7z_64bit"
alias sensors="watch -d -n 1 sensors"
alias svnup="svn up"
alias svndf="svn diff | less"

# Directory Aliases
alias pegasus="cd /home/mass/development/web/pegasus"
alias mass-web="cd /home/mass/development/web/mass-web"

# School Aliases
alias spim="QtSpim"
alias spimbot="QtSpimbot"
alias monad="../monad/monad --provided"

# Pegasus Aliases
alias pegasus-db="mysql -u root pegasus"
alias pgssh="ssh -i ~/.ssh/pegasus-prod.pem -l ubuntu"

# Development Settings
## export PATH=${PATH}:~/Dropbox/dev/android/android-sdk-linux/tools:~/Dropbox/dev/android/android-sdk-linux/platform-tools
export MAVEN_OPTS="-Xmx1024m -XX:MaxPermSize=1024m"

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
  cp -rv ~/development ~/Downloads ~/.ssh ~/.boto ~/.nvidia-settings-rc ./
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
  cat create_tables.sql create_testdata.sql | mysql -u root
  cd $OLD_DIR
}

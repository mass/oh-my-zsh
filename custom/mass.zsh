############################
# Custom ZSH Configuration #
#                          #
# Author: Andrew Mass      #
# Date:   2014-04-24       #
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
alias 225="cd /home/mass/development/db/uiuc/225"
alias 398="cd /home/mass/development/db/uiuc/398/amass2"

# Pegasus Aliases
alias pegasus-db="mysql -u root -ppass pegasus"
alias pgssh="ssh -i ~/.ssh/pegasus-prod.pem -l ubuntu"

# Development Settings
export PATH=${PATH}:~/Dropbox/dev/android/android-sdk-linux/tools:~/Dropbox/dev/android/android-sdk-linux/platform-tools
export MAVEN_OPTS="-Xmx1024m -XX:MaxPermSize=1024m"

# Backs up all the important files in my home directory
backuphome() {
  T="$(date +%s)"
  echo "Starting backup of files\n\n"
  cd /home/mass
  mkdir $(date +%F)
  cd ./$(date +%F)
  cp -rv ~/development ~/.ssh ~/.boto ~/.nvidia-settings-rc /etc/udev/rules.d/51-android.rules ./
  cd ../
  tar cvzf "Compressed-Archive-"$(date +%F).tar.gz ./$(date +%F)/
  rm -rf ./$(date +%F)
  mv "Compressed-Archive-"$(date +%F).tar.gz /home/mass/Dropbox/backups/ubuntu
  T="$(($(date +%s)-T))"
  echo "\n\nBackup completed, time elapsed: ${T}"
}

# Clean and refresh the local pegasus database
refresh-pegasus-db() {
  local OLD_DIR=$(pwd)
  cd ~/development/web/pegasus/tools
  cat create_tables.sql create_testdata.sql | mysql -u root -ppass
  cd $OLD_DIR
}

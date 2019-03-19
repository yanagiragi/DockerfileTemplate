#!/bin/bash

echo "workDirectory = $workDirectory"

# Setup Necessary Tools & SSH
apt-get update && apt-get upgrade -y 

# Install Tools
apt-get install -y openssh-server git vim curl wget inetutils-ping net-tools cron

# For add-apt-repository
apt-get install python-software-properties software-properties-common -y

# Install ffmpeg
add-apt-repository ppa:djcj/hybrid -y
apt-get install -y ffmpeg

# Install Node.js
curl -sL https://deb.nodesource.com/setup_11.x | bash - 
apt-get install -y nodejs

# Setup Npm Packages
if [ ! -f "package.json" ] ; then 
    npm install 
fi

# Get bashrc settings
curl https://gist.githubusercontent.com/yanagiragi/9672924e9f2fa1baf1ce4b6dd17592ac/raw/04838587ce726800d2679abd6df6274a64fcb4d8/.bashrc >> ~/.bashrc

# Get Vim settings
mkdir -p ~/.vim/colors
curl https://gist.githubusercontent.com/yanagiragi/1245022bc4231c7f2644782700490d18/raw/baa54fa515e978dcfe8437cc0164199f41f1ec30/atom-dark-256.vim >> ~/.vim/colors/atom-dark-256.vim
curl https://gist.githubusercontent.com/yanagiragi/d5c99f79892a4063a7db0cbcd0613892/raw/fb072865e2121eae37cf23addacaff9014e69443/.vimrc >> ~/.vimrc

# Run SSH Server in background
# /usr/sbin/sshd -D &

# Run SSH Server in background
# /usr/sbin/cron -f &

# start cron
# `which service` cron start
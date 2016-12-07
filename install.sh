#! /bin/sh
set -x
ln -sf ~/.dotfiles/.bashrc ~/.bashrc
ln -sf ~/.dotfiles/scripts/git-uncommit.sh ~/bin/git-uncommit
ln -sf ~/.dotfiles/scripts/git-thank.sh ~/bin/git-thank
ln -sf ~/.dotfiles/.hyper.js ~/.hyper.js

set +x
echo installing some other tools

# https://github.com/paulirish/git-recent/
npm install --global git-recent


echo setup ok
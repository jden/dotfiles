#! /bin/sh
set -x
ln -sf ~/.dotfiles/.bashrc ~/.bashrc
ln -sf ~/.dotfiles/scripts/git-uncommit.sh ~/bin/git-uncommit
set +x
echo setup ok
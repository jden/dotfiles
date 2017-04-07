#! /bin/sh
# Ensure this file is idempotent!

set -x
:
: profile
:
ln -sf ~/.dotfiles/.bashrc ~/.bashrc

:
: bins
:
ln -sf ~/.dotfiles/scripts/git-uncommit.sh ~/bin/git-uncommit
ln -sf ~/.dotfiles/scripts/git-thank.sh ~/bin/git-thank
ln -sf ~/.dotfiles/scripts/grit-attackclone.sh ~/bin/git-attackclone

:
: program settings
:
# Hyperterm settings
ln -sf ~/.dotfiles/.hyper.js ~/.hyper.js

case $(uname) in
  Darwin)
    # VS Code settings
    ln -sf ~/.dotfiles/.code.settings.json ~/Library/Application\ Support/Code/User/settings.json
    brew install coreutils
    ;;
  Linux)
    ;;
esac

:
: installing some other tools
:
# https://github.com/paulirish/git-recent/
npm install --global git-recent

:
: setup ok
:

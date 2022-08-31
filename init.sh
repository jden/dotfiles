#! /bin/zsh
# Ensure this file is idempotent!

DOTFILES=~/.dotfiles

if [[ "$@" =~ "-v" ]]; then VERBOSE=true fi
if [[ "$@" =~ "-vv" ]]; then set -x; fi

function STEP:() {
  print '[STEP]' $@
  : "====================================================================="
}
function DONE:() {
  print '[DONE]' $@
  : "====================================================================="
}
function LOG:() {
  $VERBOSE && print ' [LOG]' $@
  : "====================================================================="
}

function __initModule() {
  local module=$1
  local modpath=$DOTFILES/modules/$1

   if [[ -f $modpath/init.zsh ]]; then
    STEP: module init: $module
    source $modpath/init.zsh

    for F in $modpath/bin/*(N.); do
      local bname=$(basename $F)
      LOG: linking $bname
      ln -sf $F ~/bin/$bname
    done
  fi
}

:
STEP: init profile
ln -sf $DOTFILES/.zshrc ~/.zshrc
mkdir -p ~/.config ~/bin


:
STEP: config
mkdir -p ~/.config
ln -sf $DOTFILES/config/starship.toml ~/.config/starship.toml
mkdir -p ~/.config/kitty
ln -sf $DOTFILES/config/kitty.conf ~/.config/kitty/kitty.conf

:
STEP: modules
# order matters if it matters
for m (
  git
  git-status
  font
) __initModule $m


# case $(uname) in
#   Darwin)
#     # VS Code settings
#     ln -sf ~/.dotfiles/config/code.settings.json ~/Library/Application\ Support/Code/User/settings.json
#     ;;
#   Linux)
#     ;;
# esac

# :
# : install rust
# :
#curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y --no-modify-path

# :
# : installing some other tools
# :
# deps=(
#   npm
#   git-recent # https://github.com/paulirish/git-recent/
#   vega-cli # https://vega.github.io/vega/usage/#cli
# )
# npm install --global ${deps[*]}

DONE: setup ok

#! /bin/zsh

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

# DSL for "info" files
function USE:() {
  echo "  uses $1"
}
function BREW:() {
  echo "  uses $1 from homebrew"
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

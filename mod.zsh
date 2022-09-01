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
declare -A _deps
declare -a _pending
declare -a _brew

function USE:() {
  echo "  ↳ $1"
  _pending+=$1
}
function BREW:() {
  echo "  ↳ $1 (homebrew)"
  _brew+=$1
}
function GIT:() {
  echo "  ↳ $1 (git submodule)"
  #todo: automate
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

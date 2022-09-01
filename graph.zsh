#!/bin/zsh

source ./mod.zsh

function __initModule() {
  local module=$1
  local modpath=$DOTFILES/modules/$1
    echo $module

  if [[ -f $modpath/info ]]; then
    source $modpath/info
  else
    echo "  (no deps)"
    echo
  fi

  # echo p $_pending
  head=(${_pending:0:1})
  tail=(${_pending:1})
  # echo h $head
  # echo t $tail
  _pending=(${_pending:1})
  if [[ "$head" != "" ]]; then
  echo
  __initModule $head
  fi

  # TODO: break cycles
}

__initModule $1
echo
echo brew: $_brew
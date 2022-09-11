#! /bin/zsh
source $DOTFILES/lib/mod.zsh
# echo initializing git submodules for $1

GITMODULES=$DOTFILES/gitmodules

module=$1
MOD_git=()

if [[ $module == "" ]]; then
  echo "usage: $0 <module>"
  exit 1
fi

function __moduleScan() {
  function USE:() {}
  function BREW:() {}
  function CASK:() {}
  function GIT:() { MOD_git+=$1 }

  # 1) scan for

  local modpath=$(__modulePath $module)

  if [[ -f $modpath/info ]]; then
    source $modpath/info
  fi

}

__moduleScan

for M in $MOD_git; do
  STEP: submodule $M
done;

# echo gits: $MOD_git

# echo done!
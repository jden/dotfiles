#! /bin/zsh
source $DOTFILES/lib/mod.zsh
# echo initializing git submodules for $1

GITMODULES=$DOTFILES/modules/@

module=$1
MOD_git=()

if [[ $module == "" ]]; then
  echo "usage: $0 <module>"
  exit 1
fi
local modpath=$(__modulePath $module)

function __moduleScan() {
  function USE:() {}
  function BREW:() {}
  function CASK:() {}
  function GIT:() { MOD_git+=$1 }

  # 1) scan for
  if [[ -f $modpath/info ]]; then
    source $modpath/info
  fi

}

__moduleScan

for M in $MOD_git; do
  local dir=$(echo $M | sed -E 's|.*:(.*)\.git|\1|')
  STEP: " ↳ submodule: @$dir"

  if git submodule add $M $GITMODULES/$dir 2> /dev/null; then
    # this is a new submodule, in case we need to do anything with that?
    LOG: "    added git submodule @$dir"
  fi

  # run init script if present
  if [[ -f $GITMODULES/$dir/init.zsh ]]; then
    LOG: "    init"

    if [[ $VERBOSE != "" ]]; then
      source $GITMODULES/$dir/init.zsh
    else
      source $GITMODULES/$dir/init.zsh > /dev/null
    fi
  fi

  # link in parent module
  local link_as=$modpath/@$dir
  rm -rf $(dirname $link_as)
  mkdir -p $(dirname $link_as)
  ln -sf $GITMODULES/$dir $link_as
  LOG: " linking $module/@$dir → @$dir"

done;

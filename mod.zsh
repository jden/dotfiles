#! /bin/zsh
DOTFILES=~/.dotfiles
cd $DOTFILES

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
declare -a MOD_use
declare -a MOD_brew
declare -a MOD_cask
declare -a MOD_git
declare -a MOD_BREWS
declare -a MOD_CASKS
declare -a MOD_GITS

function USE:() {
  # echo "  ↳ $1"
  MOD_use+=$1
}
function BREW:() {
  # echo "  ↳ $1 (homebrew)"
  MOD_brew+=$1
}
function CASK:() {
  # sadly i think we have to treat this separately from brew
  # echo "  ↳ $1 (homebrew)"
  MOD_cask+=$1
}
function GIT:() {
  # echo "  ↳ $1 (git submodule)"
  #todo: automate
  MOD_git+=$1
}

function __modulePath() {
  print $DOTFILES/modules/$1
}

function __walkModules() {
  #sets some variables:
  local -a pending=()
  local -A seen

  declare -A MOD_CURRENT

  local module=$1
  local onModule=${2:-}

  function __moduleScan() {
    local module=$1
    local modpath=$(__modulePath $module)
    MOD_use=()
    MOD_brew=()
    MOD_cask=()
    MOD_git=()

    MOD_CURRENT[name]=$module

    if [[ -f $modpath/info ]]; then
      source $modpath/info
      MOD_CURRENT[use]=$MOD_use
      MOD_CURRENT[brew]=$MOD_brew
      MOD_CURRENT[cask]=$MOD_cask
      MOD_CURRENT[git]=$MOD_git
    fi
  }

  function __walkModulesInner() {
    local module=$1

    __moduleScan $module

    # invoke callback (if provided) for current module
    [[ $onModule != "" ]] && \
     typeset -f $onModule > /dev/null && \
     "$onModule"
  }
  pending+=$module

  while [[ ${#pending} -gt 0 ]]; do
    head=(${pending:0:1})
    pending=(${pending:1})

    # skip modules we've already traversed
    if (( ${+seen[$head]} )); then break; fi

    # map
    __walkModulesInner $head
    seen[$head]=true

    # for key in ${(k)seen}; print -r - "seen $key: $seen[$key]"

    #reduce
    for M in $MOD_use; pending+=$M;
    for M in $MOD_brew; MOD_BREWS+=$M;
    for M in $MOD_cask; MOD_CASKS+=$M;
    for M in $MOD_git; MOD_GITS+=$M;

  done

  # while pending {
  # }
}


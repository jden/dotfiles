#! /bin/zsh
# this file checks for updates to packages
source ~/.rc/lib/mod.zsh

function needs {
  ! command -v $1 > /dev/null
}

if needs brew; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

function __on_mod_cb() {
  # typeset -m 'MOD_*'
  echo $MOD_CURRENT[name] depends on:
  echo "   use $MOD_CURRENT[use]"
  echo "  brew $MOD_CURRENT[brew]"
  echo "  cask $MOD_CURRENT[cask]"
  echo "   git $MOD_CURRENT[git]"
  echo
}

__walkModules main_profile #"__on_mod_cb"

## Packages ("formulae")
##
function apply_packages() {

local -a pkg_declared=(${(@)MOD_BREWS})
local -a pkg_installed=(${(s| |)$(brew list --formula --full-name| sort)})
local -a pkg_to_install=()

for p in ${(@)pkg_declared}; do
  # array includes?
  if [[ $pkg_installed[(Ie)$p] -eq 0 ]]; then
    pkg_to_install+=$p
  fi
done

LOG: declared: $pkg_declared
# echo to_install: $pkg_to_install

if [[ "$pkg_to_install" != "" ]]; then
  LOG: installing new packages: $pkg_to_install
  brew install --formula $pkg_to_install
fi

LOG: upgrading packages
brew upgrade --formula $pkg_declared 2>/dev/null

}

## Casks
## (i know this code is repetitive, oh well)
function apply_casks() {
local -a cask_declared=(${(@)MOD_CASKS})
local -a cask_installed=(${(s| |)$(brew list --cask --full-name| sort)})
local -a cask_to_install=()

for c in ${(@)cask_declared}; do
  # array includes?
  if [[ $cask_installed[(Ie)$c] -eq 0 ]]; then
    cask_to_install+=$c
  fi
done

LOG: declared: $cask_declared
# echo to_install: $cask_to_install

if [[ "$cask_to_install" != "" ]]; then
  LOG: installing new casks: $cask_to_install
  brew install --cask $cask_to_install
fi


LOG: upgrading casks
brew upgrade --cask $cask_declared 2>/dev/null
}

############
##

:
STEP: packages

apply_packages

:
STEP: casks

apply_casks


# # do not include browsers
# casks=(
#   diffmerge
#   #hyper
#   spectacle
#   #virtualbox
#   #visual-studio-code
#   kitty
# )
# # sort and diff casks to find the new ones
# IFS=$'\n' casks=($(sort <<<"${casks[*]}")); unset IFS
# printf '%s\n' "${casks[@]}" > ${TMPDIR}f1
# brew list --cask | sort > ${TMPDIR}f2
# newCasks=$(diff -w --old-line-format='%L' --new-line-format='' --unchanged-line-format='' ${TMPDIR}f1 ${TMPDIR}f2)
# if [ "$newCasks" != "" ]; then
#   echo installing new casks: $newCasks
#   brew install $newCasks
# fi
# echo upgrading casks: "${casks[@]}"
# brew upgrade --cask "${casks[@]}"

DONE: brew ok
#!/bin/zsh
source ~/.rc/lib/mod.zsh

local errs=0

# validate modules
for f in $DOTFILES/modules/*; do
  local module=$(basename $f)
  if [[ $module == "@" ]]; then
    continue
  fi


  if ! [[ -f $f/info ]]; then
    echo $module
    echo "  missing info"
    (( errs = $errs + 1))
  fi
done

# eventually, report on modules not in use?

if [[ $errs -gt 0 ]]; then
  echo
  echo $errs errors
  exit $errs
else
  echo
  echo ok
fi

#!/bin/zsh

pushd $(dirname $0)
if [[ -d ./submod ]]; then
  pushd ./submod
  git fetch origin main && git reset --hard origin/main
  popd
else
  git clone git@github.com:junosuarez/font.git submod
fi

if [[ $VERBOSE != "" ]]; then
  sh -x ./submod/init.sh
else
  sh ./submod/init.sh > /dev/null
  LOG: installed font
fi

popd

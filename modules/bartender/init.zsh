#!/bin/zsh

pushd $(dirname $0)
if [[ -d ./submod ]]; then
  pushd ./submod
  LOG: updating
  git fetch --quiet origin main && git reset --hard origin/main
  popd
else
  LOG: cloning
  git clone git@github.com:junosuarez/rcbartender.git submod
fi

popd

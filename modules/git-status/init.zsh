#!/bin/zsh

# for some reason, brew doesnt install the bin right
ln -sf "${HOMEBREW_PREFIX:-/usr/local}/opt/gitstatus/*/usrbin/gitstatusd*" ~/bin/gitstatusd

#!/bin/zsh

function spotify() {
  local base=$(basename $0)
  $(osascript $base/spotify.apl)
}

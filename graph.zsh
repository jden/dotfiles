#!/bin/zsh
source ~/.dotfiles/mod.zsh

declare -a lines=()

function __on_mod_cb() {
  local name=${MOD_CURRENT[name]}
  if [[ ${#MOD_CURRENT[use]} -gt 0 ]]; then
    lines+="  \"$name\" -> {"
    for d in ${(z)MOD_CURRENT[use]}; do
      lines+="    \"$d\""
    done
    lines+="  }"
  fi
  if [[ ${#MOD_CURRENT[brew]} -gt 0 ]]; then
    lines+="  \"$name\" -> {"
    for d in ${(z)MOD_CURRENT[brew]}; do
      lines+="    \"b_$d\" [shape=box]"
    done
    lines+="  }"
  fi
}

lines+="digraph A {"
__walkModules main_profile "__on_mod_cb"

if [[ ${#MOD_BREWS} -gt 0 ]]; then
  lines+="  subgraph cluster_BREW { rank=same;"
  for d in ${(z)MOD_BREWS}; do
    lines+="    \"b_$d\" [shape=box, label=\"$d\"];"
  done
  lines+="    label = \"brew\";"
  lines+="  }"
fi

  lines+="  subgraph cluster_legend { color=white; shape=note; "
  lines+="    node [shape=box, label=\"brew\"]l1;"
  lines+="    node [shape=oval, label=\"module\"]l2;"
  # lines+="    label = \"key\";"
  lines+="  }"

lines+="}"

out="${(j:\n:)lines}"

if [[ "$@" =~ "-raw" ]]; then
  echo $out
else
  source $DOTFILES/modules/kitty/alias.zsh
  echo $out | idot
fi
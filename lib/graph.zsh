#!/bin/zsh
source ~/.rc/lib/mod.zsh

declare -a lines=()

if [[ "$@" =~ "-tree" ]]; then
  function __on_mod_tree_cb() {
    echo $MOD_CURRENT[name]
    for type ("use" "brew" "cask" "git"); do
    [[ ${MOD_CURRENT[$type]} != "" ]] && echo "  ↳ $type: ${MOD_CURRENT[$type]}"
    done
    echo
  }

  __walkModules main_profile "__on_mod_tree_cb"
  exit
fi

function __on_mod_cb() {
  local name=${MOD_CURRENT[name]}

  # if [[ name == "utils" ]]; then

  # fi

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
    if [[ ${#MOD_CURRENT[cask]} -gt 0 ]]; then
    lines+="  \"$name\" -> {"
    for d in ${(z)MOD_CURRENT[cask]}; do
      lines+="    \"c_$d\" [shape=box]"
    done
    lines+="  }"
  fi
  if [[ ${#MOD_CURRENT[git]} -gt 0 ]]; then
    lines+="  \"$name\" -> {"
    for d in ${(z)MOD_CURRENT[git]}; do
      local label=$(echo "$d" | sed -e 's|.*:||' -e 's|\.git||')
      lines+="    \"g_$d\" [shape=box, peripheries=2, label=\"git:$label\"]"
    done
    lines+="  }"
  fi
}

lines+="digraph A {"
lines+="layout=sfdp; pin=main_profile;"

__walkModules main_profile "__on_mod_cb"

if [[ ${#MOD_BREWS} -gt 0 || ${#MOD_CASKS} -gt 0 ]]; then
  lines+="  subgraph _BREW { color=white; style=\"dotted\";"
  for d in ${(z)MOD_BREWS}; do
    lines+="    \"b_$d\" [shape=box, label=\"brew:$d\"];"
  done

  for d in ${(z)MOD_CASKS}; do
    lines+="    \"c_$d\" [shape=box, label=\"cask:$d\", style=\"filled,solid\"; fillcolor=\"#ffffff22\"];"
  done
  lines+="  }"
fi

# if [[ ${#MOD_UTILS} -gt 0 ]]; then
#   lines+="  subgraph _UTILS { color=white; style=\"dotted\";"
#   for d in ${(z)MOD_UTILS}; do
#     lines+="    \"$d\" [shape=box, label=\"$d\"];"
#   done
#   lines+="  }"
# fi

if [[ ${#MOD_GITS} -gt 0 ]]; then
  # for d in ${(z)MOD_GITS}; do
  #   lines+="    \"g_$d\" [shape=hexagon, label=\"$d\"];"
  # done
  # lines+="  subgraph cluster_GIT { rank=same;"
  # for d in ${(z)MOD_GITS}; do
  #   lines+="    \"g_$d\" [shape=hexagon, label=\"$d\"];"
  # done
  # lines+="    label = \"git\";"
  # lines+="  }"
fi

lines+="}"

out="${(j:\n:)lines}"

if [[ "$@" =~ "-raw" ]]; then
  echo $out
echo utils: ${(@)MOD_UTILS}
elif [[ "$@" =~ "-svg" ]]; then
  source $DOTFILES/modules/kitty/alias.zsh
  local target=$DOTFILES/doc/graph.svg
  cleanpath
  echo $out | dot -Gbgcolor='#222222' -Ncolor=white -Nfontcolor=white -Nfontsize=16 -Nfontname=monospace -Ecolor=white -Tsvg > $target
  echo rendered to $target
else
  source $DOTFILES/modules/kitty/alias.zsh
  echo $out | idot
fi


desc rc-mod-graph "see modules with graphviz"
function rc-mod-graph () {
  zsh $DOTFILES/lib/graph.zsh $@
}


desc rc-mod-check "validate modules"
function rc-mod-check() {
  zsh $DOTFILES/lib/check.zsh
}



desc rc-mod-new "scaffold a new module"
function rc-mod-new() {
  local name=$1
  if [[ $name == "" ]]; then
    echo "usage: rc-new <name>"
    return 1
  fi

  if [[ -d $DOTFILES/modules/$name ]]; then
    echo $name already exists
    return 1
  fi

  mkdir -p $DOTFILES/modules/$name
  touch $DOTFILES/modules/$name/info
  touch $DOTFILES/modules/$name/profile.zsh
  touch $DOTFILES/modules/$name/alias.zsh
  touch $DOTFILES/modules/$name/init.zsh
}



function rc-mod() {
  local command="$1"
  [[ $# -gt 0 ]] && shift

  if [[ "$command" == "" || "$command" =~ "help" ]]; then
    echo "usage: rc mod <command>"
    echo
    echo "  manage rc modules"
    echo
    echo "commands:"
    for fn in ${(ok)functions[(I)rc-mod-*]}; do
      local name=$(echo $fn | sed 's/rc-mod-//')
      echo "  ${(r:8:)name}\t$(desc $fn)"
    done
    return 0
  fi

  "rc-mod-$command" $@
}

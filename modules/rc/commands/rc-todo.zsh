
desc rc-todo "see list (empty) or add a todo item (vararg)"
function rc-todo () {
  if [[ $# -eq 0 ]]; then
    # get
    command cat $DOTFILES/TODO
  else
    # add
    local todo="$@"
    echo "- [] $todo" >> $DOTFILES/TODO
    _rc-commit "todo: $todo" && echo added
  fi
}

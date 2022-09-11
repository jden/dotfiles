
function _rc-commit () {
  message="${1:-save settings}"
  gitrc commit --quiet -am "$message" || return 1
  MARK dotfiles.saved
}

function rc-commit() {
  local untracked=$(gitrc status --porcelain=1 | grep -e '^??')
  if [[ $untracked != "" ]]; then
    gitrc status
    echo
    echo "use 'gitrc add -A' if you want to continue"
    return 1
  fi

  # grab all args as one to allow for use without quotes
  local message="$*"
  _rc-commit "$message" || return 1
}


desc rc-sync "git-ify the rc"
function rc-sync () {
  # TODO: this doesnt work, need to make an inner rc-source # ensure we have the latest
  local untracked=$(gitrc status --porcelain=1 | grep -e '^??')
  if [[ $untracked != "" ]]; then
    gitrc status
    echo
    echo "use 'gitrc add -A' if you want to continue"
    return 1
  fi

  local om1=$(gitrc rev-parse origin/$MAIN_BRANCH)
  gitrc fetch origin $MAIN_BRANCH --quiet
  local om2=$(gitrc rev-parse origin/$MAIN_BRANCH)
  if [[ $om1 != $om2 ]]; then
    echo updating with remote changes
    gitrc rebase origin/$MAIN_BRANCH
    rc-init # TODO: detect when this is necessary
    rc-source
  fi
  rc-commit "$*"
  pushrc
  return 0
}

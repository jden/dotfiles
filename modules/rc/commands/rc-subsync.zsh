
desc rc-subsync "crude first pass at managing git submodules"
function rc-subsync () {
  local message="$*"
  #TODO maybe be safer adding? show which modules affected?
  git submodule foreach git add -A
  git submodule foreach git commit -am "$message"
  git submodule foreach git push
  rc-commit "$message"
  pushrc
}

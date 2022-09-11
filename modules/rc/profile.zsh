function rc() {
  if ! typeset -f rc- > /dev/null; then
  echo rc-ing $@
    source $DOTFILES/modules/rc/main.zsh
  fi
  rc- $@
}

function desc() {
  ## this abuses the aliases as an exported hashtable, since you cant well use env
  if [[ $# -eq 1 ]]; then
    # get
    echo $(alias -m "desc-$1*") | sed -e "s/desc-$1=//" -e "s/'//g"
  else
    # set
    alias "desc-$1"="$2"
  fi
}

desc rc-tip "show a random cool thing these dotfiles can do"
function rc-tip () {
  # ugh what a silly way to shell unescape... works for now though
  local aliases=$(alias | grep -v desc- | sed -E "s|^([^=]*)='?([^'].*[^'])'?\$|alias: \1 \t [\2]|")
  local tips=$(cat $DOTFILES/modules/rc/tips.txt)
  echo ""
  echo "    拾 $(echo "$aliases$tips" | shuf -n 1 -)"
  echo ""
}

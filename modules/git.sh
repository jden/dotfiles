# configs
git config --global diff.tool diffmerge
git config --global difftool.diffmerge.cmd 'diffmerge "$LOCAL" "$REMOTE"'
git config --global merge.tool diffmerge
git config --global mergetool.diffmerge.cmd 'diffmerge --merge --result="$MERGED" "$LOCAL" "$(if test -f "$BASE"; then echo "$BASE"; else echo "$LOCAL"; fi)" "$REMOTE"'
git config --global mergetool.diffmerge.trustExitCode true
git config --global alias.whomst blame
git config --global alias.whomstdve blame

# commands
function cam () {
  npm test &&
  git commit -am "$1"
}
function pull () {
  git pull origin $(whatbranch)
}
function push () {
  git push origin $(whatbranch)
}
function fush () {
  if [ $(whatbranch) == master ]; then
    echo "don't fush to master"
    printf '\a'
    return 1
  fi
  read -r -p "Really force push to $(whatbranch)? [y/N] " response
  case $response in
      [yY][eE][sS]|[yY])
          git push origin $(whatbranch) --force-with-lease
          ;;
      *)
          # do nothing
          return 1
          ;;
  esac
}
alias afush="git commit -a --amend && fush"
alias amf=afush

function tpush () {
  npm test &&
  git push origin $(whatbranch)
}

## git completions
P source "$DOTFILES/scripts/.git-completion.bash"
P source "$DOTFILES/scripts/hub.bash_completion.sh"
P source "$DOTFILES/scripts/git-prompt.sh"

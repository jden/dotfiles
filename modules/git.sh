# configs
## setup diffmerge
git config --global diff.tool diffmerge
git config --global difftool.diffmerge.cmd 'diffmerge "$LOCAL" "$REMOTE"'
git config --global merge.tool diffmerge
git config --global mergetool.diffmerge.cmd 'diffmerge --merge --result="$MERGED" "$LOCAL" "$(if test -f "$BASE"; then echo "$BASE"; else echo "$LOCAL"; fi)" "$REMOTE"'
git config --global mergetool.diffmerge.trustExitCode true
## use git+ssh instead of https
git config --global url."ssh://git@github.com".insteadOf "https://github.com"
## aliases
git config --global alias.whomst blame
git config --global alias.whomstdve blame
git config --global alias.diff-exact "diff --word-diff --word-diff-regex=."

#plumbing
alias is-git-clean="[[ $(git status --short | wc -l) -eq 0 ]]"

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


function workon () {
  # sanitize for $1 = asana url
  URL="$1"
  if [[ $1 == "" ]]; then
    read -p "Enter the asana task url: "
    URL="$REPLY"
  fi

  if [[ $URL != https://app.asana.com/* ]]; then
    echo not asana url
    return 1
  fi;

  TASK="$(basename $URL)"
  BRANCH="a$TASK"

  log_shell_event work.workon -m "$URL"

  git fetch origin master >/dev/null 2>&1

  git branch | grep $BRANCH > /dev/null
  if [[ $? == 0 ]]; then
    # if branch exists, switch to it and fetch / rebase origin master
    git checkout $BRANCH
    git rebase origin/master
  else
    # if branch doesnt exist, init
    git checkout origin/master
    git checkout -b $BRANCH
    git commit --allow-empty -m "$USER began work on $URL"
  fi

}

function github_go(){
  git_root=$(git rev-parse --show-toplevel)
  case $git_root in
    "$CODE_HOME"*)
      repo=$(echo $git_root | sed "s|$CODE_HOME/||")
      echo going to $repo on github
      ;;
    "") # not git
      return 1
      ;;
    *)
      echo not in code home
      return 1;
      ;;
  esac

  if [[ $1 != "" ]]; then
    # with number, go to that PR
    url="https://github.com/$repo/pull/$1"
    echo opening $url
    open $url
    return
  fi

  #otherwise try opening the path
  branch=$(whatbranch)
  relpath=$(pwd | sed "s|$git_root/||")
  echo relpath $relpath
  url="https://github.com/$repo/tree/$branch/$relpath"
  echo opening $url
  open $url
  return
}
alias hgo=github_go
alias hpr="hub pr list"

alias git-reset-master="echo 'resetting master, ctrl+c to abort...' && git fetch origin master && read -t 1; git checkout master && git stash && git reset origin/master --hard"
alias rsm="git-reset-master"

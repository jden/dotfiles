## git completions
# P source "$DOTFILES/scripts/.git-completion.bash"
# P source "$DOTFILES/scripts/hub.bash_completion.sh"
P source "$DOTFILES/scripts/git-prompt.sh"

## git aliases

alias gfg="git ls-files | grep"
alias gfp="gfg package.json"

alias hgo=github_go
alias hpr="hub pull-request"
alias prs="hub pr list"

# set $MAIN_BRANCH env based on the current git repo
function update_main_branch() {
  MAIN_BRANCH=$(git config --get x.main || git config --get init.defaultBranch || echo "master")
}
update_main_branch

function git-reset-main () {
  local MESSAGE
  MESSAGE="${*:-RESET} - rsm $(whatbranch)@$(git rev-parse --short HEAD) $(date +'%Y-%m-%dT%l:%M%z')"
  git stash push --include-untracked -m "$MESSAGE"
  git checkout $MAIN_BRANCH
  git fetch --force --tags origin $MAIN_BRANCH
  git reset origin/$MAIN_BRANCH --hard
}
alias rsm="git-reset-main"



#plumbing
function is-git-clean () {
  if [[ $(git status --short 2>/dev/null | wc -l) -eq 0 ]]; then
    return
  fi
  return 1
}

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

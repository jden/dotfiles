
# dotfiles management workflow
alias gitrc="git --git-dir=$DOTFILES/.git --work-tree=$DOTFILES"
alias pullrc="gitrc pull origin master"

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

desc rc-source "reload dotfile (alias: rcs)"
function rc-source () {
  source ~/.zshrc
  MARK dotfiles.resource
  printf "reloaded ~/.zshrc in %sms\n" $DOTFILES_SPAN_START_MS
}
alias rcs="rc source"

desc rc-edit "edit dotfiles (alias: rce)"
function rc-edit () {
  edit $DOTFILES
}
alias rce="rc edit"

desc rc-profile "reload shell with profiling"
function rc-profile () {
  DOTFILES_PROFILE=true
  rc-source
}

function _rc-commit () {
  message="${1:-save settings}"
  gitrc commit --quiet -am "$message" || return 1
  MARK dotfiles.saved
}
alias pushrc="gitrc push origin master"

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

desc rc-sync "do some things"
function rc-sync () {
  # TODO: this doesnt work, need to make an inner rc-source # ensure we have the latest
  local untracked=$(gitrc status --porcelain=1 | grep -e '^??')
  if [[ $untracked != "" ]]; then
    gitrc status
    echo
    echo "use 'gitrc add -A' if you want to continue"
    return 1
  fi

  local om1=$(git rev-parse origin/master)
  gitrc fetch origin master --quiet
  local om2=$(git rev-parse origin/master)
  if [[ $om1 != $om2 ]]; then
    echo updating with remote changes
    gitrc rebase origin/master
    rc-init # TODO: detect when this is necessary
  fi
  _rc-commit "$*" || return 1
  pushrc || return 1
}
desc rc-graph "see modules with graphviz"
function rc-graph () {
  zsh $DOTFILES/graph.zsh $@
}

desc rc-init "initialize modules"
function rc-init() {
  zsh $DOTFILES/init.zsh $@
}

desc rc-brew "install brew dependencies"
function rc-brew() {
  zsh $DOTFILES/brew.zsh $@
}

desc rc-log "see changes to dotfiles"
function rc-log() {
  local format='%C(dim white)%h%Creset %C(bold white)%>(15)%ar%Creset %Cgreen%d%Creset %s'
  gitrc log --pretty=format:"$format" --color=always
}
## the base command for managing dotfiles
function rc() {
  local command="$1"
  [[ $# -gt 0 ]] && shift

  if [[ "$command" == "" || "$command" =~ "help" ]]; then
    echo "usage: rc <command>"
    echo
    echo "  manage dotfiles, see https://github.com/junosuarez/.dotfiles"
    echo
    echo "commands:"
    for fn in ${(ok)functions[(I)rc-*]}; do
      local name=$(echo $fn | sed 's/rc-//')
      echo "  ${(r:8:)name}\t$(desc $fn)"
    done
    return 0
  fi

  "rc-$command" $@
}

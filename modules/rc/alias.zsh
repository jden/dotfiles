
# dotfiles management workflow
alias resource="source ~/.zshrc && MARK dotfiles.resource && echo reloaded ~/.zshrc"
alias editrc="edit $DOTFILES"
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

function _rc-commit () {
  message="${1:-save settings}"
  gitrc commit -am "$message" || return 1
  MARK dotfiles.saved
}
alias pushrc="gitrc push origin master"

desc rc-sync "do some things"
function rc-sync () {
  pullrc || return 1
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

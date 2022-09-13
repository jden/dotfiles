# dotfiles management workflow

RCMAIN_BRANCH="main"
alias gitrc="MAIN_BRANCH=$RCMAIN_BRANCH git --git-dir=$DOTFILES/.git --work-tree=$DOTFILES"
alias pullrc="gitrc pull origin $RCMAIN_BRANCH"
alias pushrc="gitrc push origin $RCMAIN_BRANCH"

for c in $DOTFILES/modules/rc/commands/*; do
    source $c
done

## the base command for managing dotfiles
function rc-() {
  local command="$1"
  [[ $# -gt 0 ]] && shift

  if [[ "$command" == "" || "$command" =~ "help" ]]; then
    echo "usage: rc <command>"
    echo
    echo "  manage dotfiles, see https://github.com/junosuarez/rc"
    echo
    echo "commands:"
    for fn in ${(ok)functions[(I)rc-*]}; do
      local name=$(echo $fn | sed 's/rc-//')
      if [[ $name =~ "-" || $name == "" ]]; then continue; fi
      echo "  ${(r:8:)name}\t$(desc $fn)"
    done
    return 0
  fi

  "rc-$command" $@
}

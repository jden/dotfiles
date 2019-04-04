# preamble
# __BASHRC_DEBUG=true
# __BASHRC_PROFILE=true

function timestamp () {
  echo $(($(gdate +%s%N)/1000000))
}
export DOTFILES_START=$(timestamp)
export DOTFILES_HOSTNAME=$(hostname -f -s)

function __profile () {
  if [[ ! $__BASHRC_PROFILE ]]; then
    $@ && return $?
  fi

  local _START=$(timestamp)
  $@
  RET=$?
  local elapsed=$(expr $(timestamp) - $_START)
  local from_start=$(expr $(timestamp) - $DOTFILES_START)
  echo '  `'"$@"'`'" $elapsed +$from_start"
  return $RET
}
alias P=__profile

function __include () {
  [[ $__BASHRC_DEBUG ]] && echo loading "modules/$1.sh"
  P source "$DOTFILES/modules/$1.sh"
}

function __endbashrc () {
  [[ $__BASHRC_DEBUG ]] || return 0
  echo bashrc took $(expr $(timestamp) - $DOTFILES_START)ms to execute
}

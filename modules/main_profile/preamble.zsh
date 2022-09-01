#!/bin/zsh
# preamble

function timestamp () {
  echo $(($(gdate +%s%N)/1000000))
}
function elapsed () {
  expr $(timestamp) - ${1:-$DOTFILES_START_MS}
}
DOTFILES_START_MS=$(timestamp)
DOTFILES_HOSTNAME=$(hostname -f -s)

## Logging
##

function _get_ssid() {
  /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}'
}
alias get_ssid="P _get_ssid"

function _log_shell_event() {
  if [[ ! __SHELL_LOG ]]; then return 0; fi

  local time=$(timestamp)
  local user=$USER
  # local network=$(get_ssid)
  local type=$1
  local message=$2
  local code=""
  local shellpid=$$

  if [[ $2 == "-m" ]]; then
    message=( "$@" )
    message=${message[*]:2}
  fi

  if [[ $2 == "-c" ]]; then
    code=( "$@" )
    code=${code[*]:2}
    message=""
  fi

  J=$(printf '{"time":%s,"shellpid":"%s","user":"%s","hostname":"%s"' $time $shellpid $user $DOTFILES_HOSTNAME)
  if [[ $network != "" ]]; then
    J="$J$(printf ',"network":"%s"' "$network")"
  else
    J="$J"',"network":null'
  fi
  J="$J$(printf ',"type":"%s"' $type)"
  if [[ $message != "" ]]; then
    J="$J$(printf ',"message":"%s"' "$message")"
  fi
  if [[ $code != "" ]]; then
    J="$J$(printf ',"code":%s' $code)"
  fi
  J="$J}"
  echo $J >> $SHELL_LOG
}
alias MARK="P _log_shell_event"

function tail_shell_log() {
  tail $1 $SHELL_LOG
}

## Profiling
##

function __profile () {
  if [[ ! $DOTFILES_PROFILE ]]; then
    $@
    return $?
  fi

  local _START=$(timestamp)
  $@
  RET=$?
  local elapsed=$(expr $(timestamp) - $_START)
  local from_start=$(elapsed)
  echo '  `'"$@"'`'" $elapsed +$from_start"
  return $RET
}
alias P=__profile

function SPAN () {
  local name=$1
  local RET
  shift
  local start=$(timestamp)

  $@
  RET=$?

  local elapsed=$(elapsed $start)
  local from_start=$(elapsed)

  local varname="DOTFILES_${name}_SPAN_MS"
  export $varname=$elapsed

  return $RET
}

function __shell_startup_end () {
  export DOTFILES_START_SPAN_MS=$(elapsed)
  DEBUG zshrc took ${DOTFILES_START_SPAN_MS}ms to execute
  MARK shell.new
}

## Module loading, etc
##

# debug logging
function DEBUG() {
  if [[ $DOTFILES_DEBUG ]]; then
    echo $@
  fi
}

# profiled, safer "source"
function SOURCE() {
  if [[ -f $1 ]]; then
    __profile source $1
  fi
}

# load a module
# $1 - name of the module to load in :/modules
function LOAD () {
  if [[ -d $DOTFILES/modules/$1 ]]; then
    DEBUG loading modules/$1/
    SOURCE $DOTFILES/modules/$1/alias.zsh
    SOURCE $DOTFILES/modules/$1/profile.zsh
  else
    # legacy non-dir version. remove soon.
    DEBUG loading modules/$1
    SOURCE $DOTFILES/modules/$1.*sh
  fi
}

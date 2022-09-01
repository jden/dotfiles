#!/bin/zsh
# preamble
zmodload zsh/datetime

# slow, do not use for math internally since it returns a string
function timestamp () {
  printf "%.0f\n" $(( $EPOCHREALTIME * 1000 ))
}

function elapsed () {
  # local val
  # local since
  # local now=$EPOCHREALTIME
  # local offset=${1:-0}
  # (( since = $offset + $DOTFILES_START_S ))
  # (( val = $now - $since ))
  # echo $val since ${1:-start} off $offset 1>&2
  # echo $val
  echo 2
}
DOTFILES_HOSTNAME=$(hostname -f -s)
local started=$EPOCHREALTIME
local -A profile_start=()
local -A profile_span=()
local -A profile_level=()
local _profile_level=0
local -a profile_name=()

## Logging
##

function _get_ssid() {
  /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}'
}
alias get_ssid="P _get_ssid"

function _log_shell_event() {
  if [[ ! $DOTFILES_LOG ]]; then return 0; fi

  (( time = $EPOCHREALTIME * 1000 ))
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

  J=$(printf '{"time":%3.0f,"shellpid":"%s","user":"%s","hostname":"%s"' $time $shellpid $user $DOTFILES_HOSTNAME)
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
  (( _profile_level = _profile_level + 1))

  local name="$@"
  (( i = ${#profile_start} + 1 ))
  profile_start[$name]=$EPOCHREALTIME
  profile_name+=$name
  profile_level[$name]=$_profile_level

  $@
  RET=$?


  (( t = $EPOCHREALTIME - profile_start[$name]))
  profile_span[$name]=$t
  (( _profile_level = _profile_level - 1))
  return $RET
}
alias P=__profile

function SPAN () {
  local name=$1
  local RET
  shift
  profile_start[$name]=$EPOCHREALTIME

  $@
  RET=$?

  (( t = ($EPOCHREALTIME - profile_start[$name]) * 1000 ))

  local varname="DOTFILES_SPAN_${name}_MS"
  export $varname=$(printf "%0.f" $t)

  return $RET
}

function __shell_startup_end () {
  DOTFILES_START_MS=$(printf "%.0f" $(( $started * 1000 )))
  DOTFILES_SPAN_START_MS=$(printf "%.0f" $((( $EPOCHREALTIME - $started ) * 1000)))
  DEBUG "zshrc took %sms to execute" $DOTFILES_SPAN_START_MS
  MARK shell.new
  if [[  $DOTFILES_PROFILE || true ]]; then
    for key in ${profile_name}; do
      (( offset = $profile_start[$key] - $started ))
      (( indent = $profile_level[$key] * 2 ))
      printf "+%3.0f %3.0f%${indent}s%s\n" $(( $offset * 1000 )) $(( profile_span[$key] * 1000 )) "•" $key
    done
  fi

  if [[ "$DOTFILES_SPAN_START_MS" -gt 500 ]]; then
    printf "🐢 dotfiles took %3.0fms\n" $(( $DOTFILES_SPAN_START_MS ))
  fi
}

## Module loading, etc
##

# debug logging
function DEBUG() {
  if [[ $DOTFILES_DEBUG ]]; then
    printf $@
    printf "\n"
  fi
}

# profiled, safer "source"
function SOURCE() {
  if [[ -f $1 ]]; then
    DEBUG "  sourcing %s" $1
    __profile source $1
  fi
}

# load a module
# $1 - name of the module to load in :/modules
function __loadModule () {
  [[ -d $DOTFILES/modules/$1 ]] || return 1

  DEBUG "loading modules/%s/" $1
  SOURCE $DOTFILES/modules/$1/alias.zsh
  SOURCE $DOTFILES/modules/$1/profile.zsh
}
alias LOAD="P __loadModule"

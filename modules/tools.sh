function demomode {
  export PS1="> "
  clear
  echo demo mode activated
  sleep .5
  clear
}

function psgrep () {
  ps ax | grep $1 | grep -v grep
}
alias psg="psgrep"

function cdl () {
  cd $1
  ls
}

function whichVersion() {
  which $1
  $1 --version
}
alias wh=whichVersion

function get_ssid() {
  /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}'
}

function log_shell_event() {
  local time=$(timestamp)
  local user=$USER
  local network=$(get_ssid)
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


  J=$(printf '{"time":%s,"shellpid","%s","user":"%s","network":"%s","type":"%s"' $time $shellpid $user $network $type)
  if [[ $message != "" ]]; then
    J="$J$(printf ',"message":"%s"' "$message")"
  fi
  if [[ $code != "" ]]; then
    J="$J$(printf ',"code":%s' $code)"
  fi
  J="$J}"
  echo $J >> $SHELL_LOG
}

function tail_shell_log() {
  tail $1 $SHELL_LOG
}

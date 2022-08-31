function demomode {
  export PS1="λ "
  clear
  echo demo mode activated
  sleep .5
  clear
}

function psgrep () {
  local PIDS
  PIDS=$(pgrep "$1" | paste -sd ',' -)
  ps u -p "$PIDS"
}
alias psg="psgrep"

alias pstop="ps ux | sort -nrk3 | head -n 10"
alias pst="pstop"

function cdl () {
  cd $1
  ls
}

# function whichVersion() {
#   which $1
#   $1 --version
# }
# alias wv=whichVersion

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

function tail_shell_log() {
  tail $1 $SHELL_LOG
}

# function secret () {
#   case $1 in
#     get)
#       NAME="$2"
#       KEYCHAIN="${3:-$HOME/Library/Keychains/login.keychain-db}"
#       SECRET=$(security find-generic-password -w -s "$2" "$KEYCHAIN" 2> /dev/null)
#       if [[ $SECRET == "" ]]; then
#         echo Could not read secret: $NAME
#         return 1
#       fi
#       echo $SECRET
#       ;;
#     help)
#       echo 'secret get <name> <keychain?>'
#       ;;
#     *)
#       echo invalid command $1, see "'secret help'"
#       return 1
#     esac
# }

function xin () {
  if [[ $1  == "-p" ]]; then
    PARALLEL="-P20"
    shift
  fi
  # cat - | xargs -n1 $PARALLEL -t (cd "$(dirname {})"; '"$@"'
  cat - | xargs -n1 $PARALLEL -I{} sh -c 'cd $(dirname {}); '"$@"
}

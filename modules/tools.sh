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

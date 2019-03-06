# login -pfq $(whoami) /usr/local/bin/bash
export DOTFILES="$HOME/.dotfiles"
export EDITOR=vim
source "$DOTFILES/modules/preamble.sh"

export SCROLLROOT="$HOME/Code/tryscroll/scroll"

# P source "$DOTFILES/.aliases"
__include aliases

export PATH="$HOME/bin:$PATH:/usr/libexec"

export JAVA_HOME=$(java_home)
export ANDROID_HOME="$HOME/Library/Android/sdk"



## Platform-specific modules

# __include ruby
__include node
__include go
__include git

__include tools


# function log() {
#   local serial=$(ls | grep "$1" | wc -l | sed -e "s/\s*//")
#   local file="$1.$serial.log"
#   date "+%c" > $file
#   echo "$*" >> $file
#   echo "---" >> $file
#   $* 2>&1 | tee -a $file ; local exitCode=${PIPESTATUS[0]}
#   echo "---" >> $file
#   echo "⇒ E$exitCode" >> $file
#   return $exitCode
# }

function echos() {
  local port=$1
  node -e "require('http').createServer(function (r, s) { console.log(r. method, r.url); s.end() }).listen($port, function (e) { console.log(e || 'listening on $port')})"
}



## Prompt
__include prompt

__endbashrc

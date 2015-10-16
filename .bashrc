PATH="$PATH:~/bin"
alias edit=subl
alias ls="ls -p" # show slashes after folders
alias ld="ls -A | grep -e ^\\." # list dotfiles
alias s=edit
alias s.="s ." # edit current directory
alias s,="s ."

# path like npm (run local bins first)
PATH="./node_modules/.bin:$PATH"

alias tdd="mocha --recursive --watch"

alias resource="source ~/.bashrc && echo reloaded ~/.bashrc"
DOTFILES="$HOME/.dotfiles"
alias editrc="edit $DOTFILES"
alias gitrc="git --git-dir=$DOTFILES/.git --work-tree=$DOTFILES"
alias pullrc="gitrc pull origin master"
alias commitrc="gitrc commit -am 'save settings'"
alias pushrc="gitrc push origin master"
alias syncrc="pullrc && commitrc && pushrc"

alias n="npm"
alias nr="npm run"

alias cd..="cd .."

function cdl () {
  cd $1
  ls
}

alias timestamp="node -p 'Date.now()'"

alias g=git
alias gst="git status"
alias glog="git log"
alias gpom="git pull origin master"
alias whatbranch="git rev-parse --abbrev-ref HEAD"
alias save="git commit -am"
alias pwb="git rev-parse --abbrev-ref HEAD" #print working branch
alias cb="git checkout" #change branch

function cam () {
  npm test &&
  git commit -am "$1"
}
function pull () {
  git pull origin $(whatbranch)
}
function push () {
  npm test &&
  git push origin $(whatbranch)
}

alias npms="npm install --save"
alias npmr="npm run"
alias npmsd="npm install --save-dev"
alias dev="cd ~/dev; ls"


function whichVersion() {
  which $1
  $1 --version
}
alias wh=whichVersion


function log() {
  local serial=$(ls | grep "$1" | wc -l | sed -e "s/\s*//")
  local file="$1.$serial.log"
  date "+%c" > $file
  echo "$*" >> $file
  echo "---" >> $file
  $* 2>&1 | tee -a $file ; local exitCode=${PIPESTATUS[0]}
  echo "---" >> $file
  echo "⇒ E$exitCode" >> $file
  return $exitCode
}

function error() {
  return $1
}

function npmrc() {
  local usage=`cat << EOF
  npmrc : list available profiles
  npmrc <name> : switch profile
  npmrc -c <name> : create a new profile
EOF`
  local user=$1
  local active=`cat ~/.npmrcs/.active`
  if [ $# -eq 0 ]; then
    echo "$usage"
    echo 
    echo available profiles:
    ls ~/.npmrcs
    echo
    echo active:
    echo $active
    return 1
  fi

  if [ $user == $active ]; then
    echo "$user is already the active user"
    return 0
  fi

  if [ $user == "-c" ]; then
    local user=$2
    echo "making new user $user"
    touch ~/.npmrcs/$user
  fi

  if [ -e ~/.npmrcs/$user ]; then
    echo "switching to user $user"
    cp -f ~/.npmrc ~/.npmrcs/$active
    cp -f ~/.npmrcs/$user ~/.npmrc
    echo $user > ~/.npmrcs/.active
  else
    echo "'$user' does not exist. use 'npmrc -c $user' to create it"
    return 1
  fi
}

function echos() {
  local port=$1
  node -e "require('http').createServer(function (r, s) { console.log(r. method, r.url); s.end() }).listen($port, function (e) { console.log(e || 'listening on $port')})"
}

alias bn="babel-node --stage 1"

function tdd() {
  local filter=$1
  if [ $# -eq 0 ]; then
    local filter=*
  fi

  mocha --recursive --watch --grep $filter
}


function __ps1_errs() {
  local err=$?
  if [ "$err" != "0" ]
  then
    echo -e "\a" #bell
    echo -e "⇒ E$err" # print err in red
  fi
}

PS1=""
PS1="$PS1"'\[\033]0;$MSYSTEM:${PWD//[^[:ascii:]]/?}\007\]' # set window title
PS1='$(__ps1_errs)\n' # show exit code
if test -z "$WINELOADERNOEXEC"
then
  PS1="$PS1"'\[\033[32m\]'       # change color
fi
PS1="$PS1"'\[\033[33m\]'       # change color
PS1="$PS1"'\w'                 # current working directory
PS1="$PS1"'\[\033[0m\]'        # change color
PS1="$PS1"'\n'                 # new line
PS1="$PS1"'$(date +%l:%M)> '                 # prompt

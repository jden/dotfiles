PATH="$PATH:$HOME/bin"
alias edit=subl
alias ls="ls -p" # show slashes after folders
alias ll="ls -al"
alias ld="ls -A | grep -e ^\\." # list dotfiles
alias s=edit
alias s.="s ." # edit current directory
alias s,="s ."
alias b="bundle exec"

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

# alias n="npm"
alias nr="npm run"

alias cd..="cd .."
alias lc="wc -l" #line count
function psgrep () {
  ps ax | grep $1 | grep -v grep
}
alias psg="psgrep"

function cdl () {
  cd $1
  ls
}

alias timestamp="node -p 'Date.now()'"

alias g=git
alias gst="git status"
alias glog="git log --graph"
alias gpom="git pull origin master"
alias whatbranch="git rev-parse --abbrev-ref HEAD"
alias br=whatbranch
alias save="git commit -am"
alias pwb="git rev-parse --abbrev-ref HEAD" #print working branch
alias cb="git checkout" #change branch
alias gitsha="git rev-parse HEAD"
alias cpsha="gitsha | pbcopy && pbpaste"
alias gpr="hub pull-request"
alias gc="hub browse"

git config --global diff.tool diffmerge
git config --global difftool.diffmerge.cmd 'diffmerge "$LOCAL" "$REMOTE"'
git config --global merge.tool diffmerge
git config --global mergetool.diffmerge.cmd 'diffmerge --merge --result="$MERGED" "$LOCAL" "$(if test -f "$BASE"; then echo "$BASE"; else echo "$LOCAL"; fi)" "$REMOTE"'
git config --global mergetool.diffmerge.trustExitCode true

function cam () {
  npm test &&
  git commit -am "$1"
}
function pull () {
  git pull origin $(whatbranch)
}
function push () {
  git push origin $(whatbranch)
}
function fush () {
  if [ $(whatbranch) == master ]; then
    echo "don't fush to master"
    printf '\a'
    return 1
  fi
  read -r -p "Really force push to $(whatbranch)? [y/N] " response
  case $response in
      [yY][eE][sS]|[yY]) 
          git push origin $(whatbranch) --force
          ;;
      *)
          # do nothing
          return 1
          ;;
  esac
}
function pusht () {
  npm test &&
  git push origin $(whatbranch)
}
function repull () {
  read -r -p "Delete local branch & repull from GH? [Y/n] " response
  case $response in
      [nN][oO]|[nN])
        return 1
          ;;
      *)
        local BRANCH=$(whatbranch)
        echo $BRANCH
        git checkout master
        git branch -D $BRANCH
        git fetch
        git checkout $BRANCH 
        ;;
  esac
}

alias npms="npm install --save"
alias npmr="npm run"
alias npmsd="npm install --save-dev"
alias dev="cd ~/dev; ls"
alias t="npm test"
alias shrink="npm prune && npm shrinkwrap"
alias reshrink="rm npm-shrinkwrap.json && shrink"

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

function __terminal_title() {
  pwd | sed "s|$HOME|~|"
}

PS1=""
PS1="$PS1"'\[\033]0;$(__terminal_title)\007\]' # set window title
PS1="$PS1"'$(__ps1_errs)\n' # show exit code
if test -z "$WINELOADERNOEXEC"
then
  PS1="$PS1"'\[\033[32m\]'       # change color
  PS1="$PS1"'$(__git_ps1 "%s") '   # bash function
fi
PS1="$PS1"'\[\033[33m\]'       # change color
PS1="$PS1"'\w'                 # current working directory
PS1="$PS1"'\[\033[0m\]'        # change color
PS1="$PS1"'\n'                 # new line
PS1="$PS1"'$(date +%l:%M)> '                 # prompt

## git completions
source "$HOME/.dotfiles/scripts/.git-completion.bash"
source "$HOME/.dotfiles/scripts/hub.bash_completion.sh"
source "$HOME/.dotfiles/scripts/git-prompt.sh"

## anybarrrrrrrrr
function anybar {
  open -g ~/Applications/AnyBar.app
  echo -n $1 | nc -4u -w0 localhost ${2:-1738};
}
alias bar=anybar

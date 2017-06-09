export DOTFILES="$HOME/.dotfiles"
source "$DOTFILES/.preamble"

export PATH="$HOME/bin:$PATH:/usr/libexec:$HOME/Library/Python/3.6/bin"
export EDITOR=vim

P source "$DOTFILES/.aliases"

function bundle_rake_test () {
  bundle exec rake test TEST=$1
}
alias brt=bundle_rake_test



# path like npm (run local bins first)
PATH="./node_modules/.bin:$PATH"
export GOPATH="$HOME/gopath"
mkdir -p $GOPATH
PATH="$GOPATH/bin:$PATH"

function psgrep () {
  ps ax | grep $1 | grep -v grep
}
alias psg="psgrep"

function cdl () {
  cd $1
  ls
}

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
          git push origin $(whatbranch) --force-with-lease
          ;;
      *)
          # do nothing
          return 1
          ;;
  esac
}
alias afush="git commit -a --amend && fush"
alias amf=afush

function tpush () {
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

function tdd() {
  local filter=$1
  if [ $# -eq 0 ]; then
    local filter=*
  fi

  mocha --recursive --watch --grep $filter
}


## anybarrrrrrrrr
function newbar {
  ANYBAR_PORT=${1:-1738} open -g ~/Applications/AnyBar.app
}
function setbar {
  PORT=${2:-1738}
  echo -n $1 | nc -4u -w0 localhost $PORT;
}
function anybar {
  PORT=${2:-1738}
  [[ $1 != "quit" ]] && newbar $PORT
  setbar $1 $PORT
}
alias bar=anybar

## Prompt
P source "$DOTFILES/.prompt"

## git completions
P source "$HOME/.dotfiles/scripts/.git-completion.bash"
P source "$HOME/.dotfiles/scripts/hub.bash_completion.sh"
P source "$HOME/.dotfiles/scripts/git-prompt.sh"

export JAVA_HOME=$(java_home)
# export NVM_DIR="/Users/jdenizac/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && P . "$NVM_DIR/nvm.sh"  # This loads nvm


# chruby
P source /usr/local/opt/chruby/share/chruby/chruby.sh
P source /usr/local/opt/chruby/share/chruby/auto.sh

# configure readline to be good:
# the original version is:
## export RUBY_CONFIGURE_OPTS="--with-readline-dir=$(brew --prefix readline) --with-openssl-dir=$(brew --prefix openssl)"
# but we cache the brew lookups for speediness:
export RUBY_CONFIGURE_OPTS="--with-readline-dir=/usr/local/opt/readline --with-openssl-dir=/usr/local/opt/openssl"

# echo bashrc took $(expr $(timestamp) - $DOTFILES_START)

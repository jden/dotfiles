alias edit=subl
alias ls="ls -p" # show slashes after folders
alias ld="ls -A | grep -e ^\\." # list dotfiles
alias s=edit
alias s.="s ." # edit current directory

alias resource="source ~/.bashrc && echo loaded .bashrc"
DOTFILES="$HOME/.dotfiles"
alias editrc="edit $DOTFILES"
alias gitrc="git --git-dir=$DOTFILES/.git --work-tree=$DOTFILES"
alias pullrc="gitrc pull origin master"
alias commitrc="gitrc commit -am 'save settings'"
alias pushrc="gitrc push origin master"
alias syncrc="pullrc && commitrc && pushrc"

alias cd..="cd .."

function cdl () {
  cd $1
  ls
}

alias g=git
alias gst="git status"
alias glog="git log"

# eg `release major`, `release minor`, `release patch`
function release () {
  npm version $1
  git push origin master `git describe --tags`
}

alias npms="npm install --save"
alias npmr="npm run"
alias npmsd="npm install --save-dev"
alias dev="cd ~/dev; ls"


whichVersion() {
  which $1
  $1 --version
}
alias wh=whichVersion

#work
alias deva="cd ~/dev/agilemd; ls; source ~/agile-env/apici.sh"
alias adenv="env | grep AD_"
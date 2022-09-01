
# dotfiles management workflow
alias resource="source ~/.zshrc && MARK dotfiles.resource && echo reloaded ~/.zshrc"
alias editrc="edit $DOTFILES"
alias gitrc="git --git-dir=$DOTFILES/.git --work-tree=$DOTFILES"
alias pullrc="gitrc pull origin master"

function commitrc () {
  message="${1:-save settings}"
  gitrc commit -am "$message" || return 1
  MARK dotfiles.saved
}
alias pushrc="gitrc push origin master"
function syncrc () {
  pullrc || return 1
  commitrc "$*" || return 1
  pushrc || return 1
}
alias graphrc="zsh $DOTFILES/graph.zsh"
alias initrc="zsh $DOTFILES/init.zsh"
alias glorc="gitrc log --pretty=format:'%C(dim white)%h%Creset %C(bold white)%>(15)%ar%Creset %Cgreen%d%Creset %s' --color=always"

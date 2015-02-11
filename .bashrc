alias edit=subl
alias ls="ls -p" # show slashes after folders
alias ld="ls -A | grep -e ^\\." # list dotfiles
alias s=edit
alias s.="s ." # edit current directory
alias editrc="edit ~/.dotfiles"
alias resource="source ~/.bashrc && echo loaded .bashrc"
alias cd..="cd .."
alias g=git
alias gst="git status"
alias glog="git log"
alias npms="npm install --save"
alias npmr="npm run"
alias npmsd="npm install --save-dev"
alias dev="cd ~/dev; ls"

#work
alias deva="cd ~/dev/agilemd; ls; source ~/agile-env/apici.sh"
alias adenv="env | grep AD_"
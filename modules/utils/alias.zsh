## navigation
##
alias ls="lsd --classify --group-dirs first " # https://github.com/Peltoche/lsd
alias less="less -R" # enable color

function clear() {
  # keep whats on screen in scrollback by printing
  # some blank lines first
  # (h/t https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Reset-the-terminal )
  printf '\n%.0s' {1..$LINES}
  command clear
}

alias cls="clear && echo 🔎 && ls"
alias la="ls -a"
alias ll="ls -al"
alias ld="ls -A | grep -e ^\\." # list dotfiles
alias l="ls"
alias tarls="tar -tvf"
alias lst="tarls"
alias cd..="cd .."

## jump
##
function ghub() {
  open "https://ghub.io/$1"
}
# alias co="cd ~/code"
# alias cj="cd ~/code/junosuarez"
# alias s="cd ~/workspace/source"
# alias sw="cd ~/workspace/web"
# alias sp="cd ~/Desktop/Projects"
# transition period, moding to a "jump" metaphor (also j is home row)
alias co="echo use: jc"
alias cj="echo use: jj"
alias s="echo use: js"
alias sw="echo use: jw"

alias jc="cd ~/code"
alias jj="cd ~/code/junosuarez"
alias j="cd ~/workspace"
alias js="cd ~/workspace/source"
alias jw="cd ~/workspace/web"

## files
##
alias cat=bat # https://github.com/sharkdp/bat
alias batdiff="git diff --name-only --diff-filter=d | xargs bat --diff"

alias jid="jid > /dev/null" # https://github.com/simeji/jid

## code
##

alias ij=intellij

## misc
##
alias blah="head /dev/urandom | base64"
alias lc="wc -l" #line count
alias join="paste -sd ',' -"

## docker
##
alias dps="docker ps --format 'table {{.Names}}\t{{.RunningFor}}' | (read; sort)"
alias dls="docker images --format 'table {{.Repository}}:{{.Tag}}\t{{.CreatedAt}}\t{{.Size}}' | (head; sort)"

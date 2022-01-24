#
alias edit=code
alias ls="CLICOLOR_FORCE=1 ls -p -G" # show slashes after folders and color
alias ls="lsd --classify --group-dirs first " # https://github.com/Peltoche/lsd
alias less="less -R" # enable color
alias cls="clear && echo 🔎 && ls"

alias la="ls -a"
alias ll="ls -al"
alias ld="ls -A | grep -e ^\\." # list dotfiles
alias l="ls"
alias blah="head /dev/urandom | base64"
alias tarls="tar -tvf"
alias lst="tarls"
alias jid="jid > /dev/null" # https://github.com/simeji/jid
alias code-stable="`which code`"
#alias code=code-insiders
alias c=code
alias c.="c ."
alias ij=intellij

alias cat=bat # https://github.com/sharkdp/bat
alias batdiff="git diff --name-only --diff-filter=d | xargs bat --diff"

# dotfiles management workflow
alias resource="source ~/.zshrc && log_shell_event dotfiles.resource && echo reloaded ~/.zshrc"
alias editrc="edit $DOTFILES"
alias gitrc="git --git-dir=$DOTFILES/.git --work-tree=$DOTFILES"
alias pullrc="gitrc pull origin master"
function commitrc () {
  message="${1:-save settings}"
  gitrc commit -am "$message" || return 1
  log_shell_event dotfiles.saved
}
alias pushrc="gitrc push origin master"
function syncrc () {
  pullrc || return 1
  commitrc "$*" || return 1
  pushrc || return 1
}
alias glorc="gitrc log --pretty=format:'%C(dim white)%h%Creset %C(bold white)%>(15)%ar%Creset %Cgreen%d%Creset %s' --color=always"

# navigation
alias co="cd ~/Code"
alias cj="cd ~/Code/junosuarez"
alias ghub="npx ghub-cli"
alias s="cd ~/workspace/source"
alias so=s # maybe a better mnemonic?
alias sw="cd ~/workspace/web"
alias sp="cd ~/Desktop/Projects"


alias dps="docker ps --format 'table {{.Names}}\t{{.RunningFor}}' | (read; sort)"
alias dls="docker images --format 'table {{.Repository}}:{{.Tag}}\t{{.CreatedAt}}\t{{.Size}}' | (head; sort)"

alias cd..="cd .."
alias lc="wc -l" #line count

# terminal
alias icat="kitty icat --align=left"
alias isvg="rsvg-convert --dpi-x=120 --dpi-y=120 | icat"
alias isvg2="rsvg-convert --zoom=2 | icat"
## require npm i -g vega-cli, draws vega lite charts
alias ivl="vl2svg | isvg2"
## dot with default styles, reference https://graphviz.org/doc/info/attrs.html
alias idot="dot -Gbgcolor=transparent -Ncolor=white -Nfontcolor=white -Nfontsize=16 -Nfontname=monospace -Ecolor=white -Tsvg | isvg"
function itex() {
  tex2svg "$1" | sed 's|</svg>|<style>*{fill:white;}</style></svg>|' | rsvg-convert --zoom 3 | icat
}

# git aliases
alias g=git
alias gst="git status"
alias gj="git status"
alias glo="git log --pretty=format:'%C(dim white)%h%Creset %C(bold white)EML%aEEML%Creset  %Cgreen%d%Creset %s' --color=always | sed 's/EML\(.\{1,7\}\).*@.*EML/EML\1     EML/; s/EML\(.\{7\}\).*EML/\1/' | less -R"
alias glog="git log --graph"
alias gam="git commit -a --amend"
function gpom(){
  git pull origin $MAIN_BRANCH
}
alias whatbranch="git rev-parse --abbrev-ref HEAD"
alias br=whatbranch
alias pws="git log -1 --pretty=%H" # print working sha
alias save="git commit -am"
alias pwb="git rev-parse --abbrev-ref HEAD" #print working branch
alias cb="git checkout" #change branch
alias cb-="cb -"
function cbm() {
  cb $MAIN_BRANCH
}
alias gitsha="git rev-parse HEAD"
alias gitref="gitsha"
alias cpsha="gitsha | pbcopy && pbpaste"
alias gpr="hub pull-request"
alias gf="git fetch"
alias gh="hub browse"
function rmbr() {
  # remove merged branches
  git branch --merged $MAIN_BRANCH | grep -v " $MAIN_BRANCH" | xargs git branch -d
}
function grm() {
  git fetch && git rebase origin/$MAIN_BRANCH
}
function gri() {
  git fetch && git rebase origin/$MAIN_BRANCH -i
}
alias grit="git"
alias pushpr="push && hub pull-request"
# alias rmbranches="[[ $(git rev-parse --abbrev-ref HEAD) == master ]] && git branch --no-merged | xargs -p git branch -D"
# alias cleanreviews="[[ $(git rev-parse --abbrev-ref HEAD) == master ]] && git branch --no-merged | grep review- | xargs -p git branch -D"
function git_grep_source(){
  git grep -I $@ *.{java,js,jsx,ts,tsx}
}
alias gg="git_grep_source"
function ggjava () {
  git grep -I $@ *.{java}
}
function gfom() {
  git fetch origin $MAIN_BRANCH --tags
}
function grom() {
  git rebase origin/$MAIN_BRANCH
}

# clean up the files left by my git mergetool
# shellcheck disable=SC2142 # the $2 below isn't a positional arg, it's an awk column reference
alias cleanorig="git status --untracked-files --porcelain | grep -e '^?? .*\.orig' | awk '{print \$2}' | xargs rm"

# work
alias gitw="git --git-dir=$SCROLL_HOME/.git --work-tree=$SCROLL_HOME"
alias sc="cd $SCROLL_HOME"
function sg () {
  gitw grep -I $@ *.{java,js,jsx,ts,tsx}
}
alias scs="cd $SCROLL_HOME/server"
function sgs () {
  gitw grep -I $@ $SCROLL_HOME/server/**/*.java
}
alias scc="cd $SCROLL_HOME/client"
alias sca="cd $SCROLL_HOME/../analytics"
alias scf="cd $SCROLL_HOME/cloud-functions"
function sgc () {
  gitw grep -I $@ $SCROLL_HOME/client/**/*.{js,jsx,ts,tsx}
}
alias review='sc && log_shell_event work.review -m "$@" && $SCROLL_HOME/review.sh'
alias scn="cd ~/Code/Nuzzel"

# npm workflow
alias npmi="npm install"
alias npmt="npm test"
alias npmr="npm run"
alias shrink="npm prune && npm shrinkwrap"
alias reshrink="rm npm-shrinkwrap.json && shrink"

alias yup="yarn upgrade-interactive --latest"

# docker
alias dii="docker image inspect"
alias dci="docker container inspect"

# tools
alias keychain="open '/Applications/Utilities/Keychain Access.app'"

# kubernetes
alias k=kubectl
alias ko="kubectl -o yaml"

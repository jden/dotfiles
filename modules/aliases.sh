#
alias edit=code
alias ls="CLICOLOR_FORCE=1 ls -p -G" # show slashes after folders and color
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

# dotfiles management workflow
alias resource="source ~/.bashrc && log_shell_event dotfiles.resource && echo reloaded ~/.bashrc"
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


alias dps="docker ps --format 'table {{.Names}}\t{{.RunningFor}}' | (read; sort)"
alias dls="docker images --format 'table {{.Repository}}:{{.Tag}}\t{{.CreatedAt}}\t{{.Size}}' | (head; sort)"

alias cd..="cd .."
alias lc="wc -l" #line count


# git aliases
alias g=git
alias gst="git status"
alias glo="git log --pretty=format:'%C(dim white)%h%Creset %C(bold white)EML%aEEML%Creset  %Cgreen%d%Creset %s' --color=always | sed 's/EML\(.\{1,7\}\).*@.*EML/EML\1     EML/; s/EML\(.\{7\}\).*EML/\1/' | less -R"
alias glog="git log --graph"
alias gam="git commit -a --amend"
alias gpom="git pull origin master"
alias whatbranch="git rev-parse --abbrev-ref HEAD"
alias br=whatbranch
alias pws="git log -1 --pretty=%H" # print working sha
alias save="git commit -am"
alias pwb="git rev-parse --abbrev-ref HEAD" #print working branch
alias cb="git checkout" #change branch
alias cb-="cb -"
alias gitsha="git rev-parse HEAD"
alias gitref="gitsha"
alias cpsha="gitsha | pbcopy && pbpaste"
alias gpr="hub pull-request"
alias gf="git fetch"
alias gh="hub browse"
alias rmbr="git branch --merged master | grep -v ' master$' | xargs git branch -d" # remove merged branches
alias grm="git fetch && git rebase origin/master"
alias gri="git fetch && git rebase origin/master -i"
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

# work
alias gitw="git --git-dir=$SCROLL_HOME/.git --work-tree=$SCROLL_HOME"
alias sc="cd $SCROLL_HOME"
function sg () {
  gitw grep -I $@ *.{java,js,jsx,ts,tsx}
}
alias scs="cd $SROLL_HOME/server"
function sgs () {
  gitw grep -I $@ $SCROLL_HOME/server/**/*.java
}
alias scc="cd $SCROLL_HOME/client"
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

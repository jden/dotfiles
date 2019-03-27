#
alias edit=code
alias ls="CLICOLOR_FORCE=1 ls -p -G" # show slashes after folders and color
alias less="less -R" # enable color
alias cls="clear && echo 🔎 && ls"
alias la="ls -a"
alias ll="ls -al"
alias ld="ls -A | grep -e ^\\." # list dotfiles
alias l="ls"
alias s=edit
alias s.="s ." # edit current directory
alias s,="s ."
alias b="bundle exec"
alias bt="b ruby -Ilib/test"
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
alias commitrc="gitrc commit -am 'save settings' && log_shell_event dotfiles.saved"
alias pushrc="gitrc push origin master"
alias syncrc="pullrc && commitrc && pushrc"

# navigation
alias cj="cd ~/Code/jsdnxx"
alias ghub="npx ghub-cli"


alias dps="docker ps --format 'table {{.Names}}\t{{.RunningFor}}' | (read; sort)"
alias dls="docker images --format 'table {{.Repository}}:{{.Tag}}\t{{.CreatedAt}}\t{{.Size}}' | (head; sort)"

alias cd..="cd .."
alias lc="wc -l" #line count


# git aliases
alias g=git
alias gst="git status"
alias glo="git log --pretty=format:'%C(dim white)%h%Creset %C(bold white)EML%aEEML%Creset  %Cgreen%d%Creset %s' --color=always | sed 's/EML\(.\{1,6\}\).*@.*EML/EML\1     EML/; s/EML\(.\{6\}\).*EML/\1/' | less -R"
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
# alias rmbranches="[[ $(git rev-parse --abbrev-ref HEAD) == master ]] && git branch --no-merged | xargs -p git branch -D"
# alias cleanreviews="[[ $(git rev-parse --abbrev-ref HEAD) == master ]] && git branch --no-merged | grep review- | xargs -p git branch -D"
alias gg="git grep"

# work
alias sc="cd ~/Code/tryscroll/scroll"
alias scs="cd ~/Code/tryscroll/scroll/server"
alias scc="cd ~/Code/tryscroll/scroll/client"
alias review='sc && log_shell_event work.review -m "$@" && $SCROLL_HOME/review.sh'

# npm workflow
alias npmi="npm install"
alias npmt="npm test"
alias npmr="npm run"
alias shrink="npm prune && npm shrinkwrap"
alias reshrink="rm npm-shrinkwrap.json && shrink"

# docker
alias dii="docker image inspect"
alias dci="docker container inspect"

# tools
# alias yarn="npx yarn"
# temporary, see https://github.com/Schniz/fnm/issues/59
alias fnm-upgrade="curl https://raw.githubusercontent.com/Schniz/fnm/master/.ci/install.sh | bash -s -- --skip-shell"
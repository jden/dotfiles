#!/bin/zsh
# git aliases and functions

alias g=git
alias gst="git status"
alias gj="git status"
export GLOF="%h%n%aE%n%s%n"
alias glo="git log --pretty=format:\"$GLOF\" | awk -f $DOTFILES/modules/git/glo.awk | less -RS"
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
alias rss="git fetch origin master && git reset --hard && git checkout"

# clean up the files left by my git mergetool
# shellcheck disable=SC2142 # the $2 below isn't a positional arg, it's an awk column reference
alias cleanorig="git status --untracked-files --porcelain | grep -e '^?? .*\.orig' | awk '{print \$2}' | xargs rm"

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
alias rss="git fetch origin master && git reset --hard && git checkout"

# clean up the files left by my git mergetool
# shellcheck disable=SC2142 # the $2 below isn't a positional arg, it's an awk column reference
alias cleanorig="git status --untracked-files --porcelain | grep -e '^?? .*\.orig' | awk '{print \$2}' | xargs rm"

alias gff="git fast-forward" # defined in init.zsh
alias rbi="git rebase --interactive"

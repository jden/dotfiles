#!/bin/zsh

SOURCE "${HOMEBREW_PREFIX:-/usr/local}/opt/gitstatus/gitstatus.plugin.zsh" || return
gitstatusd_instance='GSD'
# the following are a mystery - why do they define the fn names with $1?
alias gitstatus_query=gitstatus_querysource
alias gitstatus_start=gitstatus_startsource
alias gitstatus_stop=gitstatus_stopsource

function chalk() {
  print -P "%$1F$2%f"
}

# export some env vars we pick up in statship config
function _gitstatus_prompt_update() {

  gitstatus_query $gitstatusd_instance || return 1  # error
  [[ $VCS_STATUS_RESULT == 'ok-sync' ]] || {
    # not a git repo
    unset GSD_STATUS
    unset GSD_BRANCH_STATUS
    unset GSD_HINT
    unset GSD_ON
    unset GSD_REPO
    export GSD_NOT_REPO="1"
    return 0
  }
  # populates a bunch fo variables prefixed with:
  # typeset -m 'VCS_STATUS_*'

  local BRANCH_STATUS=""
  local STATUS=""
  local HINT=""
  local ON=""
  local REMOTE=""

  # see https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#Character-Highlighting
  # for COLOR in {0..255}
  # do
  # print -P "%${COLOR}F${COLOR}%f"
  # done
  local  GREEN='76'
  local YELLOW='178'
  local   BLUE='39'
  local    RED='196'
  local  WHITE='195'

  local      ahead="" #	⇡
  local     behind="" # ⇣
  local   diverged="" # ⇕
  local conflicted=""
  local up_to_date="﫠"	#
  local  untracked=""	# ?
  local   modified=""	# !
  local     staged=""	# +
  local    renamed="" #	»
  local    deleted="" # ✘

  if [[ $VCS_STATUS_COMMITS_AHEAD -gt 0 ]]; then
    if [[ $VCS_STATUS_COMMITS_BEHIND -gt 0 ]]; then
      BRANCH_STATUS="$(chalk $YELLOW $diverged)"
      HINT="git sync needed"
    else
      BRANCH_STATUS="$(chalk $YELLOW $ahead)"
      HINT="git push changes"
    fi
  else
  if [[ $VCS_STATUS_COMMITS_BEHIND -gt 0 ]]; then
      BRANCH_STATUS="$(chalk $YELLOW $behind)"
      HINT="git rebase"
    else
      BRANCH_STATUS="$(chalk $WHITE $up_to_date)"
    fi
  fi

  if [[ $VCS_STATUS_HAS_UNTRACKED -gt 0 ]]; then
    STATUS="$STATUS $(chalk $GREEN $untracked)"
    HINT="git add new files"
  fi

  if [[ $VCS_STATUS_HAS_STAGED  -gt 0 ]]; then
    STATUS="$STATUS $(chalk $GREEN $staged)"
    HINT="git commit changes"
  fi

  if [[ $VCS_STATUS_NUM_UNSTAGED_DELETED  -gt 0 ]]; then
    STATUS="$STATUS $(chalk $RED $deleted)"
    HINT="git rm deleted files"
  else
    if [[ $VCS_STATUS_HAS_UNSTAGED  -gt 0 ]]; then
      STATUS="$STATUS $(chalk $GREEN $modified)"
      HINT="git commit changes"
    fi
  fi

  if [[ $VCS_STATUS_NUM_CONFLICTED  -gt 0 ]]; then
      STATUS="$STATUS $(chalk $RED $conflicted)"
      HINT="resolve merge conflict"
    fi

  if [[ "$VCS_STATUS_LOCAL_BRANCH" != "" ]]; then
    ON="${VCS_STATUS_LOCAL_BRANCH:0:20}"
  else
    ON="${VCS_STATUS_COMMIT:0:7}"
  fi

  case "$VCS_STATUS_REMOTE_URL" in
    *@github.com*)
      REMOTE=""
      ;;
    *twitter.*)
      REMOTE="暑"
      ;;
  esac

# if [[ $HINT != "" ]]; then
#   HINT=$(chalk $YELLOW " $HINT")
# fi

 # eg VCS_STATUS_ACTION=rebase-i
 # not top priority, because getting current action is cheap in starship

  export GSD_STATUS="$STATUS"
  export GSD_BRANCH_STATUS="$BRANCH_STATUS"
  export GSD_HINT="$HINT"
  export GSD_ON="$ON"
  export GSD_REPO="$(basename $VCS_STATUS_REMOTE_URL | sed 's|\.git$||')"
  export GSD_REMOTE="$REMOTE"

  unset GSD_NOT_REPO
  # echo update $STATUS $HINT $ON

  # while we're here, let's keep it fresh
  gsd_refresh
}
function gitstatus_prompt_update() {
  SPAN GSD _gitstatus_prompt_update
}

function gsd_refresh() {
  local LAST_REFRESHED=$(git config --local --get gsd.refresh 2> /dev/null || true)
  local NOW=$(gdate +%s)
  local ELAPSED_SEC=$(($NOW - ${LAST_REFRESHED:-0}))
  # echo last $LAST_REFRESHED
  # echo now $NOW
  # echo elapsed $ELAPSED_SEC
  if [[ $ELAPSED_SEC -gt 300 ]]; then
    # echo refreshing
    git config --local --add gsd.refresh $NOW
    (&>/dev/null nohup grep -q .biz /etc/resolv.conf && git fetch origin master &)
  fi
}

function gitstatusd_up() {
  gitstatus_stopsource 'GSD' && gitstatus_startsource -s -1 -u -1 -c -1 -d -1 'GSD'
}

gitstatusd_up
# On every prompt, fetch git status and set GITSTATUS_PROMPT.
autoload -Uz add-zsh-hook
add-zsh-hook precmd gitstatus_prompt_update

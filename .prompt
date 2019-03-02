function __ps1_errs() {
  local err=$?
  if [ "$err" != "0" ]
  then
    echo -e "⇒ E$err" # print err in red
  fi
}

function __terminal_title() {
  echo "$__TITLE$(pwd | sed "s|$HOME|~|")"
}

function __set_title() {
  export __TITLE="$1 "
  case "$TERM" in
  screen*) # set window title tmux
    printf '\033k$1\033\\'
    ;;
  xterm*) # set window title in iterm, etc
    printf '\033]0;$1\007'
    ;;
  esac
}
alias name=__set_title

PS1=""
PS1="$PS1"'$(__ps1_errs)\n' # show exit code
case "$TERM" in
  screen*) # set window title tmux
    PS1="$PS1"'\033k$(__terminal_title)\033\\'
    ;;
  xterm*) # set window title in iterm, etc
    PS1="$PS1"'\[\033]0;$(__terminal_title)\007\]'
    ;;
esac
# # set window title iterm
if test -z "$WINELOADERNOEXEC"
then
  PS1="$PS1"'\[\033[32m\]'       # change color
  PS1="$PS1"'$(__git_ps1 "%s") '   # bash function
fi
PS1="$PS1"'\[\033[33m\]'       # change color
PS1="$PS1"'\w'                 # current working directory
PS1="$PS1"'\[\033[0m\]'        # change color
PS1="$PS1"' $(date +%l:%M) 🍕\n'
PS1="$PS1"'λ '                 # prompt

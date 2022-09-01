#! /bin/zsh
function __terminal_title() {
  echo "$__TITLE$(pwd | sed "s|$HOME/workspace/source|~Src|; s|$HOME/workspace/web|~Web|; s|$HOME/workspace|~Wk|; s|$SCROLL_HOME|~Scroll|; s|$HOME|~|;")"
}

function set_title() {
  export __TITLE="$@ "
  case "$TERM" in
  screen*) # set window title tmux
    printf '\033k$1\033\\'
    ;;
  xterm*) # set window title in iterm, etc
    printf '\033]0;$1\007'
    ;;
  esac
}

# this will be run prior to printing starship prompt
function prompt_hook() {
  case "$TERM" in
    screen*) # set window title tmux
      printf '\033k$(__terminal_title)\033\\'
      ;;
    xterm*) # set window title in kitty, etc
      printf '\033]0;'"$(__terminal_title)"'\007'
      ;;
  esac

  # starship captures $? as $STATUS
  #if [ "$STATUS" != "0" ]; then
  #  MARK program.error -c $STATUS
  #  echo -e "⇒ E$STATUS" # print err
  #fi

  MARK prompt
}
add-zsh-hook precmd prompt_hook

LOAD git-status

eval "$(starship init zsh)"
# export STARSHIP_LOG=error # disable slow git command warnings

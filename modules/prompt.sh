#! /bin/bash
function __terminal_title() {
  echo "$__TITLE$(pwd | sed "s|$HOME/workspace/source|~Src|; s|$HOME/workspace/web|~Web|; s|$HOME/workspace|~Wk|; s|$SCROLL_HOME|~Scroll|; s|$HOME|~|;")"
}

function __set_title() {
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
alias name=__set_title

function __get_emoji () {
  hour=$(gdate +%H)
  case $hour in
  06|07)
    echo lies.
    ;;
  08|09|10)
    echo 🍵
    ;;
  11|12|13)
    echo 🍕
    ;;
  14|15|16)
    echo 🚰
    ;;
  17|18)
    echo 🚋
    ;;
  *)
    echo 😴
    ;;
  esac
}



# PS1='$(__ps1_errs)\n'"$PS1" # show exit code

# # PS1="$PS1"'$(git status origin/master --short --branch)\n'
# PS1="$PS1"'$(is-git-clean && echo ✨ || echo 🥀)'
# PS1="$PS1"'\[\033[32m\]'       # change color
# PS1="$PS1"'$(__git_ps1 "%s")' # bash function
# PS1="$PS1"'\[\033[33m\]'       # change color
# PS1="$PS1"' \w'                 # current working directory
# PS1="$PS1"'\[\033[0m\]'        # change color
# PS1="$PS1"' \D{%l:%M} $(__get_emoji)\n'
# PS1="$PS1"'λ '                 # prompt
# PS1="$PS1"'$(__end_prompt)'    # trigger
# echo "$PS1"


# this will be run prior to printing starship prompt
function prompt_hook() {

  case "$TERM" in
    screen*) # set window title tmux
      printf '\033k$(__terminal_title)\033\\'
      ;;
    xterm*) # set window title in iterm, etc
      printf '\033]0;'"$(__terminal_title)"'\007'
      ;;
  esac

  # starship captures $? as $STATUS
  #if [ "$STATUS" != "0" ]; then
  #  log_shell_event program.error -c $STATUS
  #  echo -e "⇒ E$STATUS" # print err
  #fi

  log_shell_event prompt
}

eval "$(starship init zsh)"
export STARSHIP_LOG=error # disable slow git command warnings



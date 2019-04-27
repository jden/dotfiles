# login -pfq $(whoami) /usr/local/bin/bash
export DOTFILES="$HOME/.dotfiles"
export EDITOR=vim
source "$DOTFILES/modules/preamble.sh"


export CODE_HOME="$HOME/Code"
export SCROLL_HOME="$CODE_HOME/tryscroll/scroll"

# P source "$DOTFILES/.aliases"
__include aliases

export PATH="$HOME/bin:$PATH:/usr/libexec"
PATH="$PATH:/usr/local/opt/gettext/bin" #grr @ brew

export JAVA_HOME=$(java_home)
export ANDROID_HOME="$HOME/Library/Android/sdk"

export SHELL_LOG="$HOME/.shell_log"

## Platform-specific modules

# __include ruby
__include node
__include go
__include git_profile
__include tools

## Prompt
__include prompt

log_shell_event shell.new

__endbashrc

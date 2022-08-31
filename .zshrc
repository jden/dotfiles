export HISTFILESIZE=99999

export DOTFILES="$HOME/.dotfiles"
export EDITOR=vim
source "$DOTFILES/modules/preamble.sh"


export CODE_HOME="$HOME/Code"
export SCROLL_HOME="$CODE_HOME/tryscroll/scroll"

__include aliases

export PATH="$HOME/bin:$PATH:/usr/libexec:/usr/local/sbin"
PATH="$PATH:/usr/local/opt/gettext/bin" #grr @ brew

# android!
# export ANDROID_HOME=$HOME/Library/Android/sdk
# PATH="$PATH:$ANDROID_HOME/emulator"
# PATH="$PATH:$ANDROID_HOME/tools"
# PATH="$PATH:$ANDROID_HOME/tools/bin"
# PATH="$PATH:$ANDROID_HOME/platform-tools"

# export JAVA_HOME=$(/usr/libexec/java_home -v 11 2>/dev/null)
# export CATALINA_HOME="/usr/local/Cellar/tomcat@6/6.0.53/libexec/"

export SHELL_LOG="$HOME/.shell_log"

## Platform-specific modules

# __include ruby
__include node
# __include go
__include git

__include tools
__include rust

## Prompt
__include prompt

log_shell_event shell.new

__endbashrc

## Hooks (using zsh)
autoload -U add-zsh-hook

# add-zsh-hook chpwd load-nvmrc
add-zsh-hook precmd prompt_hook
add-zsh-hook chpwd update_main_branch

# initialize autocompletions
autoload -Uz compinit
compinit

# optional work stuff (not in this repo)
if [ -f "$HOME/.dotfiles/.workrc" ]; then
  source "$HOME/.dotfiles/.workrc"
fi

# note: see the .zlogin file, which runs once per shell _after_ .zshrc, for additional setup

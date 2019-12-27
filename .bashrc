export HISTFILESIZE=99999

export DOTFILES="$HOME/.dotfiles"
export EDITOR=vim
source "$DOTFILES/modules/preamble.sh"


export CODE_HOME="$HOME/Code"
export SCROLL_HOME="$CODE_HOME/tryscroll/scroll"

__include aliases

export PATH="$HOME/bin:$PATH:/usr/libexec"
PATH="$PATH:/usr/local/opt/gettext/bin" #grr @ brew

# android!
export ANDROID_HOME=$HOME/Library/Android/sdk
PATH="$PATH:$ANDROID_HOME/emulator"
PATH="$PATH:$ANDROID_HOME/tools"
PATH="$PATH:$ANDROID_HOME/tools/bin"
PATH="$PATH:$ANDROID_HOME/platform-tools"

export JAVA_HOME=$(java_home)
export CATALINA_HOME="/usr/local/Cellar/tomcat@6/6.0.53/libexec/"

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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

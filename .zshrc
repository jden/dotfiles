# see .env for debug + profiling flags
DOTFILES="$HOME/.dotfiles"
source $DOTFILES/.env
source "$DOTFILES/modules/main_profile/preamble.sh"
__include aliases

## Use zsh hooks
autoload -U add-zsh-hook

__include main_profile

add-zsh-hook chpwd update_main_branch

# initialize autocompletions
autoload -Uz compinit
compinit

# optional work stuff (not in this repo)
if [ -f "$HOME/.dotfiles/.workrc" ]; then
  source "$HOME/.dotfiles/.workrc"
fi

# note: see the .zlogin file, which runs once per shell _after_ .zshrc, for additional setup

log_shell_event shell.new

__endbashrc

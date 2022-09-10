# see .env for debug + profiling flags
DOTFILES="$HOME/.rc"
source $DOTFILES/.env
source "$DOTFILES/modules/main_profile/preamble.zsh"

## Use zsh hooks
autoload -U add-zsh-hook

LOAD main_profile

# initialize autocompletions
autoload -Uz compinit
compinit

# optional work stuff (not in this repo)
SOURCE "$DOTFILES/.workrc"

# note: see the .zlogin file, which runs once per shell _after_ .zshrc, for additional setup

__shell_startup_end

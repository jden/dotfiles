# see .env for debug + profiling flags
export DOTFILES="$HOME/.rc"
source $DOTFILES/.env
source "$DOTFILES/modules/main_profile/preamble.zsh"

## Use zsh hooks
autoload -U add-zsh-hook

LOAD main_profile

# initialize autocompletions
autoload -Uz compinit
compinit

# optional work stuff (not in this repo)
source "$DOTFILES/.workrc"

__shell_startup_end

# note: see the .zlogin file, which runs _after_ .zshrc

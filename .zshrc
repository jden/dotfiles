# see .env for debug + profiling flags
DOTFILES="$HOME/.dotfiles"
source $DOTFILES/.env
source "$DOTFILES/modules/main_profile/preamble.zsh"

## Use zsh hooks
autoload -U add-zsh-hook

LOAD main_profile

add-zsh-hook chpwd update_main_branch

# initialize autocompletions
autoload -Uz compinit
compinit

# optional work stuff (not in this repo)
SOURCE "$HOME/.dotfiles/.workrc"

# note: see the .zlogin file, which runs once per shell _after_ .zshrc, for additional setup

__shell_startup_end

# Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
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
SOURCE "$DOTFILES/.workrc"

__shell_startup_end

# note: see the .zlogin file, which runs _after_ .zshrc

# Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"

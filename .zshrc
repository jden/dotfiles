# Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
# see .env for debug + profiling flags
export DOTFILES="$HOME/.rc"
source $DOTFILES/.env
source "$DOTFILES/modules/main_profile/preamble.zsh"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_HOME="$XDG_CONFIG_HOME"

## Use zsh hooks
autoload -U add-zsh-hook

LOAD main_profile

# initialize autocompletions
autoload -Uz compinit
compinit

# optional work stuff (not in this repo)
SOURCE "$DOTFILES/.workrc"
SOURCE "$DOTFILES/.localrc"

__shell_startup_end

# note: see the .zlogin file, which runs _after_ .zshrc

# Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/juno/.cache/lm-studio/bin"

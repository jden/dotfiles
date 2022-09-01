#! /bin/zsh
# Ensure this file is idempotent!
source ./mod.zsh

:
STEP: init profile
ln -sf $DOTFILES/.zshrc ~/.zshrc
mkdir -p ~/.config ~/bin


:
STEP: config
mkdir -p ~/.config
mkdir -p ~/.config/kitty
ln -sf $DOTFILES/config/kitty.conf ~/.config/kitty/kitty.conf

:
STEP: modules
# order matters if it matters
for m (
  git
  git-status
  starship
  font
) __initModule $m


# case $(uname) in
#   Darwin)
#     # VS Code settings
#     ln -sf ~/.dotfiles/config/code.settings.json ~/Library/Application\ Support/Code/User/settings.json
#     ;;
#   Linux)
#     ;;
# esac

# :
# : install rust
# :
#curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y --no-modify-path

# :
# : installing some other tools
# :
# deps=(
#   npm
#   git-recent # https://github.com/paulirish/git-recent/
#   vega-cli # https://vega.github.io/vega/usage/#cli
# )
# npm install --global ${deps[*]}

DONE: setup ok

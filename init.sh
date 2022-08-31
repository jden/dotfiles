#! /bin/sh
# Ensure this file is idempotent!

set -x
:
: profile
:
ln -sf ~/.dotfiles/.zshrc ~/.zshrc
#ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf

:
: .config
:
mkdir -p ~/.config
ln -sf ~/.dotfiles/config/starship.toml ~/.config/starship.toml
mkdir -p ~/.config/kitty
ln -sf ~/.dotfiles/config/kitty.conf ~/.config/kitty/kitty.conf

:
: bin
:
mkdir -p ~/bin
for F in ~/.dotfiles/bin/*; do
  ln -sf $F ~/bin/$(basename $F)
done


:
: modules
:
modules=(
  git
)
for M in "${modules[@]}"; do
  if [[ -f modules/$M/init.sh ]]; then
    : module init: $M
    source modules/$M/init.sh

    for F in modules/$M/bin/*; do
      ln -sf $F ~/bin/$(basename $F)
    done
  fi
done



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

:
: installing fonts
:
[[ -d ./font ]] || git clone git@github.com:junosuarez/font.git
./font/init.sh

:
: setup ok
:

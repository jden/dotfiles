#! /bin/zsh
# Ensure this file is idempotent!
source ~/.rc/lib/mod.zsh

function __initModule() {
  local module=$1
  local modpath=$DOTFILES/modules/$module

  STEP: "$module"

  if grep -q GIT: "$modpath/info"; then
    # LOG: $module has git submodules
    $DOTFILES/lib/init-submod.zsh $module
  fi

   if [[ -f $modpath/init.zsh ]]; then
    LOG: " init"
    source $modpath/init.zsh

    for F in $modpath/bin/*(N.); do
      local bname=$(basename $F)
      LOG: " linking bin: $bname"
      ln -sf $F ~/bin/$bname
    done

  fi
}

############
##

:
STEP: init profile
ln -sf $DOTFILES/.zshrc ~/.zshrc
mkdir -p ~/.config ~/bin


:
STEP: config
mkdir -p ~/.config
ln -sf $DOTFILES/config/kitty.conf ~/.config/kitty/kitty.conf

:
STEP: modules

ENTRY=${1:-main_profile}

__walkModules $ENTRY
for m in ${(o)MOD_USES}; do
  __initModule $m
done

# order matters if it matters
# for m (
#   git
#   git-status
#   starship
#   font
#   kitty
#   window_mgr
# ) __initModule $m


case $(uname) in
  Darwin)
    # VS Code settings
    ln -sf $DOTFILES/config/code.settings.json ~/Library/Application\ Support/Code/User/settings.json
    ;;
  Linux)
    ;;
esac

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

DONE: 'init ok. optional: `rc brew`'

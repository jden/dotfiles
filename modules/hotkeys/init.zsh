# karabiner
mkdir -p ~/.config/karabiner/assets/complex_modifications
ln -sf $DOTFILES/modules/hotkeys/remap.json ~/.config/karabiner/assets/complex_modifications/remap.json

# hammerspoon
mkdir -p ~/.hammerspoon
ln -sf $DOTFILES/modules/hotkeys/hammerspoon.lua ~/.hammerspoon/init.lua

mkdir -p ~/.hammerspoon/Spoons
find $DOTFILES/modules/hotkeys/@Hammerspoon/Spoons/Spoons/*.spoon.zip \
  | xargs -n1 -I{} sh -c 'unzip -oq {} -d ~/.hammerspoon/Spoons'

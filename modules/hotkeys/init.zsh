# karabiner
mkdir -p ~/.config/karabiner/assets/complex_modifications
ln -sf $DOTFILES/modules/hotkeys/remap.json ~/.config/karabiner/assets/complex_modifications/remap.json

# hammerspoon
mkdir -p ~/.hammerspoon
ln -sf $DOTFILES/modules/hotkeys/hammerspoon.lua ~/.hammerspoon/init.lua
rm -f ~/.hammerspoon/Spoons
ln -sf $DOTFILES/modules/hotkeys/@Hammerspoon/Spoons/Source ~/.hammerspoon/Spoons

ln -sf /Applications/Hammerspoon.app/Contents/Frameworks/hs/hs ~/bin/hs

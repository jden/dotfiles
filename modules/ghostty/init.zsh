CFG="${XDG_CONFIG_HOME:-$HOME/.config}/ghostty"
mkdir -p $CFG
ln -sf $DOTFILES/modules/ghostty/config $CFG/config

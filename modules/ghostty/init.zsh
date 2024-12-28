CFG="${XDG_CONFIG_HOME:-$HOME/.config}/ghostty"
mkdir -p $CFG
ln -sf $DOTFILES/modules/ghostty/config $CFG/config

for file in $DOTFILES/modules/ghostty/shaders/*.glsl; do
  shader=$(basename $file)
  echo "Processing $shader"
  ln -sf $file $CFG/$shader
done

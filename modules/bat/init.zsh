# setup hacklang syntax support
# see https://github.com/rhysd/bat/blob/master/README.md#adding-new-syntaxes--language-definitions
# this uses our bat config already in this repo in /.config

# after installing the sublime-hacklang git repo from `info`,
# symlink it into ~/.config/bat/syntaxes
# TODO: currently modules don;t init in proper dependency order, so this will fail on first run
ln -sf $DOTFILES/modules/hacklang/@albertxing/sublime-hacklang/Hack.sublime-syntax $DOTFILES/.config/bat/syntaxes/Hack.sublime-syntax
bat cache --build

# to confirm:
bat -L | grep -q "Hack:hh,php,hack"

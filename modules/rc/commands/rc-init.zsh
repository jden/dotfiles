desc rc-init "initialize modules"
function rc-init() {
  zsh $DOTFILES/init.zsh $@
}

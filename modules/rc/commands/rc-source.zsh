
desc rc-source "reload dotfile (alias: rcs)"
function rc-source () {
  source ~/.zshrc
  MARK dotfiles.resource
  printf "reloaded ~/.zshrc in %sms\n" $DOTFILES_SPAN_START_MS
}

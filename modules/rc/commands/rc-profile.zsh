
desc rc-profile "reload shell with profiling"
function rc-profile () {
  DOTFILES_PROFILE=true
  rc-source
}

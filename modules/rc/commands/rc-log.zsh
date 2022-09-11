desc rc-log "see changes to dotfiles"
function rc-log() {
  local format='%C(dim white)%h%Creset %C(bold white)%>(15)%ar%Creset %Cgreen%d%Creset %s'
  gitrc log --pretty=format:"$format" --color=always
}

#!/bin/zsh

for m (
  ## Platform-specific modules
  git
  node
  utils
  ssh-agent
  rust
  ## Prompt
  prompt
  kitty
  rc
  vscode
) LOAD $m

# show an educational tip on new shell
rc-tip

#!/bin/zsh

for m (
  ## Platform-specific modules
  git
  node
  tools
  ssh-agent
  rust
  ## Prompt
  prompt
  kitty
  rc
) LOAD $m

# show an educational tip on new shell
rc tip
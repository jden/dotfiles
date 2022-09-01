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
) LOAD $m

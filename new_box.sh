packages=(
  tmux
)
brew install ${packages[*]}

casks=(
  google-chrome
  virtualbox
  iterm2
  spectacle
  visual-studio-code
  diffmerge
)
brew cask install ${casks[*]}

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
  virtualbox
)
brew cask install ${casks[*]}

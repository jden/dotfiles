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
)
brew cask install ${casks[*]}

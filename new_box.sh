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

# fnm + node
curl https://raw.githubusercontent.com/Schniz/fnm/master/.ci/install.sh | bash -s -- --skip-shell
fnm install latest
fnm use latest

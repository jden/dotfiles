#! /bin/bash
# this file checks for updates to packages
packages=(
  tmux
  jid
  coreutils
  inetutils
  reattach-to-user-namespace # see see https://github.com/Microsoft/vscode/issues/12587#issuecomment-280681178
  cloc
)
brew install ${packages[*]}
brew upgrade

casks=(
  hyper
  google-chrome
  firefox
  virtualbox
  spectacle
  visual-studio-code
  diffmerge
)
brew cask install ${casks[*]}
brew cask upgrade

curl https://raw.githubusercontent.com/Schniz/fnm/master/.ci/install.sh | bash -s -- --skip-shell

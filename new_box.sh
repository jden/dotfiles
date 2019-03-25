function needs {
  ! command -v $1 > /dev/null
}

if needs brew; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

packages=(
  tmux
  jid
)
brew install ${packages[*]}

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

# fnm + node
if needs fnm; then
  curl https://raw.githubusercontent.com/Schniz/fnm/master/.ci/install.sh | bash -s -- --skip-shell
  ln -sf ~/.fnm/fnm ~/bin/fnm
  fnm install latest
  fnm use latest
fi

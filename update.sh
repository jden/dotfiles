#! /bin/bash
# this file checks for updates to packages
packages=(
  tmux
  jid
  coreutils
  inetutils
  reattach-to-user-namespace # see see https://github.com/Microsoft/vscode/issues/12587#issuecomment-280681178
  cloc
  stubby # secure dns
  lsd # ls replacement https://github.com/Peltoche/lsd
)
brew install "${packages[*]}"
brew upgrade

# setup stubby
sudo brew services start stubby
sudo /usr/local/opt/stubby/sbin/stubby-setdns-macos.sh
ln -sf ~/.dotfiles/files/stubby.yml /usr/local/etc/stubby/stubby.yml

casks=(
  hyper
  google-chrome
  firefox
  virtualbox
  spectacle
  visual-studio-code
  diffmerge
)
brew cask install "${casks[*]}"
brew cask upgrade

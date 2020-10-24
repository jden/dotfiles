#! /bin/sh
# Ensure this file is idempotent!

set -x
:
: profile
:
ln -sf ~/.dotfiles/.bashrc ~/.bashrc
ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf

:
: bins
:
mkdir -p ~/bin ~/.config
cp -r ~/.dotfiles/bin ~
ln -sf ~/.dotfiles/scripts/git-uncommit.sh ~/bin/git-uncommit
ln -sf ~/.dotfiles/scripts/git-thank.sh ~/bin/git-thank
ln -sf ~/.dotfiles/scripts/grit-attackclone.sh ~/bin/git-attackclone
ln -sf ~/.dotfiles/.status ~/bin/status
ln -sf ~/.dotfiles/config/starship.toml ~/.config/starship.toml
mkdir -p ~/.config/kitty
ln -sf ~/.dotfiles/config/kitty.conf ~/.config/kitty/kitty.conf

# binstub for git alias `git cloc`
cat << EOF > ~/bin/git-cloc
#! /bin/bash
cloc -vcs=git
EOF
chmod +x ~/bin/git-cloc

:
: program settings
:
# Hyperterm settings
ln -sf ~/.dotfiles/config/hyper.js ~/.hyper.js
source ~/.dotfiles/modules/git_install.sh

case $(uname) in
  Darwin)
    # VS Code settings
    ln -sf ~/.dotfiles/config/code.settings.json ~/Library/Application\ Support/Code/User/settings.json
    # set global git ignore
    git config --global core.excludesfile ~/.dotfiles/config/gitignore
    ;;
  Linux)
    ;;
esac

:
: install rust
:
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y --no-modify-path

:
: installing some other tools
:
deps=(
  npm
  git-recent # https://github.com/paulirish/git-recent/
  vega-cli # https://vega.github.io/vega/usage/#cli
)
npm install --global ${deps[*]}

:
: installing fonts
:
# curl https://raw.githubusercontent.com/adobe-fonts/source-code-pro/release/OTF/SourceCodePro-Regular.otf  > ~/Library/Fonts/SourceCodePro-Regular.otf
# install patched nerdfonts version of Source Code Pro https://www.nerdfonts.com/font-downloads
TMP=$(mktemp)
rm "$TMP"
mkdir -p "$TMP"
cd "$TMP" || exit
curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/SourceCodePro.zip > tmp.zip
unzip tmp.zip
rm tmp.zip
cp -- *.ttf ~/Library/Fonts/
rm -rf "$TMP"

:
: setup ok
:

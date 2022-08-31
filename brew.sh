#! /bin/bash
# this file checks for updates to packages

function needs {
  ! command -v $1 > /dev/null
}

if needs brew; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew cleanup

packages=(
  cloc
  coreutils
  inetutils
  jid # json incremental digger
  jq  # jsonquery
  lsd # ls replacement https://github.com/Peltoche/lsd
  #reattach-to-user-namespace # see see https://github.com/Microsoft/vscode/issues/12587#issuecomment-280681178
  #stubby # secure dns
  #tmux
  p7zip # handle various archive formats https://www.7-zip.org/
  #imagemagick
  graphviz
  bat # cat with syntax highlighting https://github.com/sharkdp/bat
  #git-absorb # fixup atomic commits https://github.com/tummychow/git-absorb
  fzf # fuzzy find https://github.com/junegunn/fzf#usage
)

# sort and diff packages to find the new ones
IFS=$'\n' packages=($(sort <<<"${packages[*]}")); unset IFS
printf '%s\n' "${packages[@]}" > ${TMPDIR}f1
brew list --formula | sort > ${TMPDIR}f2
newPackages=$(diff -w --old-line-format='%L' --new-line-format='' --unchanged-line-format='' ${TMPDIR}f1 ${TMPDIR}f2)

if [ "$newPackages" != "" ]; then
  echo installing new packages: $newPackages
  brew install $newPackages
fi
echo upgrading packages: "${packages[@]}"
brew upgrade --formula "${packages[@]}"

# setup stubby, if newly installed
# if [[ "$newPackages" == *"stubby"* ]]; then
#   echo installing stubby, will ask for root pw
#   sudo brew services start stubby
#   sudo /usr/local/opt/stubby/sbin/stubby-setdns-macos.sh
#   ln -sf ~/.dotfiles/config/stubby.yml /usr/local/etc/stubby/stubby.yml
# fi

# do not include browsers
casks=(
  diffmerge
  #hyper
  spectacle
  #virtualbox
  #visual-studio-code
  kitty
)
# sort and diff casks to find the new ones
IFS=$'\n' casks=($(sort <<<"${casks[*]}")); unset IFS
printf '%s\n' "${casks[@]}" > ${TMPDIR}f1
brew list --cask | sort > ${TMPDIR}f2
newCasks=$(diff -w --old-line-format='%L' --new-line-format='' --unchanged-line-format='' ${TMPDIR}f1 ${TMPDIR}f2)
if [ "$newCasks" != "" ]; then
  echo installing new casks: $newCasks
  brew install $newCasks
fi
echo upgrading casks: "${casks[@]}"
brew upgrade --cask "${casks[@]}"

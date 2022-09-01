#! /bin/zsh
# this file checks for updates to packages
source ~/.dotfiles/mod.zsh

function needs {
  ! command -v $1 > /dev/null
}

if needs brew; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

function __on_mod_cb() {
  # typeset -m 'MOD_*'
  echo $MOD_CURRENT[name] depends on:
  echo "   use $MOD_CURRENT[use]"
  echo "  brew $MOD_CURRENT[brew]"
  echo "   git $MOD_CURRENT[git]"
  echo
}

__walkModules main_profile #"__on_mod_cb"
echo
echo brew: $MOD_BREWS
# brew install "${MOD_BREWS[@]}"


# exit


# # brew cleanup

packages=(${(@)MOD_BREWS})

# sort and diff packages to find the new ones
IFS=$'\n' packages=($(sort <<<"${packages[*]}")); unset IFS
printf '%s\n' "${packages[@]}" > ${TMPDIR}f1
brew list --formula | sort > ${TMPDIR}f2
newPackages=$(diff -w --old-line-format='%L' --new-line-format='' --unchanged-line-format='' ${TMPDIR}f1 ${TMPDIR}f2)

# todo: handle packages from taps

if [ "$newPackages" != "" ]; then
  echo installing new packages: $newPackages
  brew install $newPackages
fi

echo upgrading packages: "${packages[@]}"
brew upgrade --formula "${packages[@]}" 2>/dev/null

# # setup stubby, if newly installed
# # if [[ "$newPackages" == *"stubby"* ]]; then
# #   echo installing stubby, will ask for root pw
# #   sudo brew services start stubby
# #   sudo /usr/local/opt/stubby/sbin/stubby-setdns-macos.sh
# #   ln -sf ~/.dotfiles/config/stubby.yml /usr/local/etc/stubby/stubby.yml
# # fi

# # do not include browsers
# casks=(
#   diffmerge
#   #hyper
#   spectacle
#   #virtualbox
#   #visual-studio-code
#   kitty
# )
# # sort and diff casks to find the new ones
# IFS=$'\n' casks=($(sort <<<"${casks[*]}")); unset IFS
# printf '%s\n' "${casks[@]}" > ${TMPDIR}f1
# brew list --cask | sort > ${TMPDIR}f2
# newCasks=$(diff -w --old-line-format='%L' --new-line-format='' --unchanged-line-format='' ${TMPDIR}f1 ${TMPDIR}f2)
# if [ "$newCasks" != "" ]; then
#   echo installing new casks: $newCasks
#   brew install $newCasks
# fi
# echo upgrading casks: "${casks[@]}"
# brew upgrade --cask "${casks[@]}"

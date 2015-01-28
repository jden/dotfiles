# .dotfiles

## installation

```sh
cd ~
git clone git@github.com:jden/.dotfiles.git
ln ~/.dotfiles/.bashrc .bashrc
```

### windows
with mingw
```sh
cd ~
git clone git@github.com:jden/.dotfiles.git
ln ~/.dotfiles/windows/.bashrc .bashrc
rm ~/AppData/Roaming/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings
ln ~/.dotfiles/Preferences.sublime-settings ~/AppData/Roaming/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings
```
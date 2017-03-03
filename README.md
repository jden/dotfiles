# .dotfiles

note for people who aren't me: these are a total mess and have been schlepped about from system to system over several years. it's stuff that i'm used to and have muscle memory for, but certainly not stuff i can recommend that other's copy. consider y'selves warned.

## installation

```sh
cd ~
git clone git@github.com:jden/.dotfiles.git
./install.sh
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

cat > ~/.profile
source ~/.dotfiles/windows/.bashrc
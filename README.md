# .dotfiles

these are (for the most part) my daily driver dotfiles
they're not really organized for public consumption,
but do what you like

## installation

```sh
cd ~
git clone git@github.com:junosuarez/.dotfiles.git
./init.sh
```

## show dotfiles on macos:

`CMD + SHIFT + .`

## modules
this is a way of organizing related things for a specific tool
the directory structure looks something like this:

```
 /modules
   /module
     /init.sh     # idempotent, setup basic config
     /bin         # optional, contents get linked to ~/bin
```



### windows (no longer really supported)

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

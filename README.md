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
     /info        # module manifest, uses DSL (see below)
     /init.sh     # idempotent, setup basic config that modifies the system
     /bin         # optional, contents get linked to ~/bin
     /alias.sh    # optional, shell aliases
     /profile.sh  # optional, shell profile
```

### `info` manifest
this is evaluated as a shell file, use these special functions to specify dependencies:

- `USE: <module>` depend on another module within this repo
- `BREW: <package>` depend on a package from homebrew


see `./graph.zsh` to explore the module dependency graph

Q: is this whole system a litte elaborate for a personal dotfiles repo?
A: yes.

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

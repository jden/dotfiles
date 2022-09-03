mkdir -p ~/.vim
mkdir -p ~/.vim/colors
mkdir -p ~/.vim/autoload
ln -sf $DOTFILES/modules/vim/.vimrc ~/.vimrc
ln -sf $DOTFILES/modules/vim/colors/onedark.vim ~/.vim/colors/onedark.vim
ln -sf $DOTFILES/modules/vim/autoload/onedark.vim ~/.vim/autoload/onedark.vim

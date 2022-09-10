# source this, not run it
set -x


# FROM=~/.dotfiles
# NEXT=~/.rc


# reset while iterating on migrate:
export DOTFILES=$FROM
rm -rf ~/.rc
rm -rf ~/.dotfiles
rm -rf ~/.dotfiles.bak
cp -rp ~/.bak/. ~/.dotfiles



rm -rf $NEXT
mkdir -p $NEXT


gitrc checkout -b main
gitrc remote set-url origin git@github.com:junosuarez/rc.git
# # eventually remove master branch

# echo $DOTFILES
if ! [[ -L $FROM ]]; then
  echo $FROM not link, copy to cp and link
  cp -rp $FROM/. $NEXT
  mv $FROM ${FROM}.bak
  export DOTFILES=$NEXT
  ln -sf $NEXT $FROM
else
  echo $FROM already link
fi

set +x

echo
echo "here's what we did:"
echo " * moved branch to main"
echo " * moved origin repo to junosuarez/rc"
echo " * moved dotfiles path to ~/.rc"
echo " * temporarily symlinked old ~/.dotfiles to ~/.rc"
echo " * saved a backup copy in ~/.dotfiles.bak"
echo
echo "check it out:"
la ~
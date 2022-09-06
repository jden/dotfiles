#!/bin/zsh
# configs
# must be idempotent

## me
git config --global user.name juno suárez
git config --get user.email > /dev/null || git config --global user.email juno@localhost

## setup diffmerge
git config --global diff.tool diffmerge
git config --global difftool.diffmerge.cmd 'diffmerge "$LOCAL" "$REMOTE"'
git config --global merge.tool diffmerge
git config --global mergetool.diffmerge.cmd 'diffmerge --merge --result="$MERGED" "$LOCAL" "$(if test -f "$BASE"; then echo "$BASE"; else echo "$LOCAL"; fi)" "$REMOTE"'
git config --global mergetool.diffmerge.trustExitCode true

## make pull safe
git config --global pull.ff only
git config --global branch.autosetuprebase always # no merge commits

## have sensible upstream push behavior for new branches
git config --global push.default current

## use git+ssh instead of https
git config --global url."ssh://git@github.com".insteadOf "https://github.com"

## aliases
git config --global alias.thank blame
git config --global alias.whom blame
git config --global alias.whomst blame
git config --global alias.whomstdve blame
git config --global alias.diff-exact "diff --word-diff --word-diff-regex=."
git config --global alias.find 'ls-files'
git config --global alias.fast-forward "rebase origin"
git config --global alias.fixup "commit --all --fixup=amend"
# set global git ignore
git config --global core.excludesfile $DOTFILES/modules/git/global-gitignore

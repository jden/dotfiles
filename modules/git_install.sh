# configs

## setup diffmerge
git config --global diff.tool diffmerge
git config --global difftool.diffmerge.cmd 'diffmerge "$LOCAL" "$REMOTE"'
git config --global merge.tool diffmerge
git config --global mergetool.diffmerge.cmd 'diffmerge --merge --result="$MERGED" "$LOCAL" "$(if test -f "$BASE"; then echo "$BASE"; else echo "$LOCAL"; fi)" "$REMOTE"'
git config --global mergetool.diffmerge.trustExitCode true

## use git+ssh instead of https
git config --global url."ssh://git@github.com".insteadOf "https://github.com"

## aliases
git config --global alias.whomst blame
git config --global alias.whomstdve blame
git config --global alias.diff-exact "diff --word-diff --word-diff-regex=."
git config --global alias.find 'ls-files'

# path like npm (run package-local bins first)
PATH="./node_modules/.bin:$PATH"

function tdd() {
  local filter=$1
  if [ $# -eq 0 ]; then
    local filter=*
  fi

  mocha --recursive --watch --grep $filter
}


function bumpdep() {
  if [ ! -f package.json ]; then
    echo must be in a dir with package.json
    return
  fi

  DEP=$1
  REF=$DEP@latest
  DEV=$2

  if [ $(cat package.json | jq --arg d "$DEP" '[.dependencies["$d"] != null, .devDependencies["$d"] != null] | any' -e) ]; then
    TYPE=transitive
  else
    TYPE=direct
  fi

  echo upgrading $DEP as a $TYPE dep...

  # get latest version of the dep
  if [ $TYPE == transitive ]; then
    yarn add $REF $DEV
  else
    yarn upgrade $REF $DEV
  fi

  # dedupe transitive dependencies which can be satisfied by upgraded version
  npx yarn-deduplicate --packages $DEP

  # cleanup if added
  if [ $TYPE == transitive ]; then
    yarn remove $DEP
  fi

  yarn why $DEP
}

## nvm support
export NVM_DIR="$HOME/.nvm"
# a stub to lazy-load nvm
nvm () {
  \. "$NVM_DIR/nvm.sh"  # This loads nvm
  \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  nvm $@
  return $?
}

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
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# export NVM_DIR="$HOME/.nvm"
# # a stub to lazy-load nvm
# nvm () {
#   \. "$NVM_DIR/nvm.sh"  # This loads nvm
#   \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#   nvm $@
#   return $?
# }

autoload -U add-zsh-hook
load-nvmrc() {
  echo calling nvmrc
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
# path like npm (run local bins first)
PATH="./node_modules/.bin:$PATH"

function tdd() {
  local filter=$1
  if [ $# -eq 0 ]; then
    local filter=*
  fi

  mocha --recursive --watch --grep $filter
}

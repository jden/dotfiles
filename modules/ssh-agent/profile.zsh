# configure ssh agent for key forwarding

# the default thing spawns a new agent in every shell
# this results in too many processes!
# eval "$(ssh-agent)" > /dev/null

SSH_AGENT=~/.ssh-agent

function __tryLoadSshAgent() {
  if [[ -f $SSH_AGENT ]]; then
    source $SSH_AGENT > /dev/null
    if ! ps -p $SSH_AGENT_PID > /dev/null; then
      [[ $__BASHRC_DEBUG ]] && echo agent not running $SSH_AGENT_PID
      rm $SSH_AGENT
      __spawnSshAgent
    fi
  else
    __spawnSshAgent
  fi
}

function __spawnSshAgent() {
    ssh-agent > $SSH_AGENT
    source $SSH_AGENT > /dev/null
    #
    ssh-add --apple-use-keychain -q
}

__tryLoadSshAgent

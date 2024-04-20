
# if server isn't running, start it
if ! ps aux | grep -q "ollama serve"; then
  # TODO - system service?
  ollama serve &
fi

# if model isn't local, pull it
if ! ollama list | grep -q "llama3:latest"; then
  echo this takes a while...
  # TODO do i want to defer this until like.... after init-time? probably?
  ollama pull llama3
fi

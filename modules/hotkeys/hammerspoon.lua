-- see https://www.hammerspoon.org/docs/hs.hotkey.html

hs.hotkey.bind("ctrl+option+shift", "z", function()
  -- use with karabiner mod
  hs.application.launchOrFocus("kitty")
end)

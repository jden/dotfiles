-- see https://www.hammerspoon.org/docs/hs.hotkey.html

-- hs.hotkey.bind("ctrl+option+shift", "z", function()
--   -- use with karabiner mod
--   hs.application.launchOrFocus("kitty")
-- end)

hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

hs.hotkey.bind("ctrl+option+cmd", "right", function()
  -- MoveToNextDisplay
  hs.application.launchOrFocus("kitty")
end)

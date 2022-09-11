-- see https://www.hammerspoon.org/docs/hs.hotkey.html

-- hs.hotkey.bind("ctrl+option+shift", "z", function()
--   -- use with karabiner mod
--   hs.application.launchOrFocus("kitty")
-- end)

hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

hs.loadSpoon("WindowHalfsAndThirds")
hs.loadSpoon("WindowScreenLeftAndRight")
spoon.WindowScreenLeftAndRight:bindHotkeys(spoon.WindowScreenLeftAndRight.defaultHotkeys)

hs.window.animationDuration = 0

hs.hotkey.bind("ctrl+option+cmd", "right", function()
  -- MoveToNextDisplay
  hs.application.launchOrFocus("kitty")
end)

hs.hotkey.bind("ctrl+cmd", "right", function()
  -- MoveToRightHalf
  local win = hs.window.frontmostWindow()
  spoon.WindowHalfsAndThirds:rightHalf(win)
end)

hs.hotkey.bind("ctrl+cmd", "left", function()
  -- MoveToLeftHalf
  -- hs.alert.show("l")
  local win = hs.window.frontmostWindow()
  spoon.WindowHalfsAndThirds:leftHalf(win)
end)

hs.hotkey.bind("ctrl+cmd", "up", function()
  -- MoveToFullscreen
  local win = hs.window.frontmostWindow()
  win:move(hs.layout.maximized)
end)

-- as fate would have it, these are the default
-- hot keys for spoon.WindowScreenLeftAndRight:bindHotkeys(spoon.WindowScreenLeftAndRight.defaultHotkeys)
-- hs.hotkey.bind("ctrl+option+cmd", "left", function()
--   -- MoveToPreviousDisplay
--   local win = hs.window.frontmostWindow()
--   win:move(hs.layout.maximized)
-- end)

-- hs.hotkey.bind("ctrl+option+cmd", "right", function()
--   -- MoveToNextDisplay
--   local win = hs.window.frontmostWindow()

-- end)
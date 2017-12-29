-- functions

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

-- configuration

hs.window.animationDuration = 0

-- caffeine

hs.urlevent.bind("caffeinate-toggle", function(eventName, params)
    state = hs.caffeinate.toggle("displayIdle")
    stateStr = state and "enabled" or "disabled"

    hs.alert.show("Caffeinate is " .. stateStr)
end)

hs.hotkey.bind({"ctrl", "command"}, "Q", function()
	hs.caffeinate.startScreensaver()
end);

-- window management

hs.hotkey.bind({"cmd", "alt"}, "F", function()
	hs.window.focusedWindow():maximize()
end);

-- fullscreen

function fullscreen(window)
	if (not window:isFullScreen()) then
		window:setFullScreen(true)
	end
end

function isInScreen(screen, win)
  return win:screen() == screen
end

function focusScreen(screen)
  win = hs.window.focusedWindow()
  local windows = hs.fnutils.filter(
      hs.window.orderedWindows(),
      hs.fnutils.partial(isInScreen, screen))
  local windowToFocus = #windows > 0 and windows[1] or hs.window.desktop()
  windowToFocus:focus()

  local pt = geometry.rectMidPoint(screen:fullFrame())
  mouse.setAbsolutePosition(pt)
end

hs.hotkey.bind({"alt"}, "`", function ()
  focusScreen(hs.window.focusedWindow():screen():next())
end)

hs.hotkey.bind({"alt", "shift"}, "`", function()
  focusScreen(hs.window.focusedWindow():screen():previous())
end)

-- run

myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

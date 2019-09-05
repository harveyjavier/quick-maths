-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- include the Corona "composer" module
composer = require "composer"
widget = require "widget"
physics = require "physics"
vibrator = require "plugin.vibrator"
loadsave = require "lib.loadsave"
inspect = require "lib.inspect"
color = require "lib.convertcolor"

-- dynamic background
display.setDefault("background", color.hex("ffce42"))

local function onGlobalKeyEvent( event )
	if (event.keyName == "back") then
		return true
	end
end
Runtime:addEventListener("key", onGlobalKeyEvent)

-- load menu screen
composer.gotoScene( "menu" )
-- Hide the status bar.
display.setStatusBar(display.HiddenStatusBar)

-- require controller module
local composer = require("composer")

-- Load the widget
local widget = require("widget")

--預設背景顏色
display.setDefault( "background", 0.4, 0.6, 0.4 )

-- load first scene
composer.gotoScene( "item", "fade", 400 )

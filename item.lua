
-- require controller module
local composer = require("composer")
local item = composer.newScene()

-- Load the widget
local widget = require("widget")


--中間點的座標
local centerX = display.contentCenterX
local centerY = display.contentCenterY

--裝置的大小
local drviceW = display.contentWidth
local drviceH = display.contentHeight

--螢幕的大小
local screenX = display.contentWidth - (display.screenOriginX * 2 )
local screenY = display.contentHeight - (display.screenOriginY * 2 )

local function ButtonLearn_Handle()
    composer.gotoScene( "learn", "slideLeft", 400 )
end  --ButtonTen_Handle End

local function ButtonLearn1_Handle()
    composer.gotoScene("learn1","slideLeft",400)
end  --ButtonLearn1-Handle 

local function ButtonGame1_Handle()
    composer.gotoScene("game1","slideRight",400)
end --ButtonGame1_Handle

local function ButtonGame2_Handle()
    composer.gotoScene("game2","slideLeft",400)
end --ButtonGame1_Handle

local function ButtonTEST_Handle()
    composer.gotoScene( "test", "crossFade", 1000 )
end  --ButtonTen_Handle End

--離開程式的函數
local function ButtonExit_Handle()
    --判斷是否為Android或iOS
    if  system.getInfo("platformName")=="Android" then
        native.requestExit()
    else
        os.exit() 
    end
end 

function item:create( event )
    local sceneGroup = self.view 

    --背景圖片
    local GLpngbg = display.newImageRect( "png01.png",screenX,screenY )
    GLpngbg.x=centerX
    GLpngbg.y=centerY
    --GLpngbg:scale( 0.9, 1 )
    sceneGroup:insert(GLpngbg)

    -- 測試
    local ButtonTEST = widget.newButton
    {
        label = "測試",
        labelColor = { default={ 0, 0, 0 } },
        fontSize = 20,
        onEvent = ButtonTEST_Handle ,
        emboss = false,
        --properties for a rounded rectangle button...
        shape="roundedRect",
        width = 100,
        height = 60,
        cornerRadius = 10,
        fillColor = { default={ 1, 0.7, 0.5, 1 }, over={ 0.3, 0.9, 0.3, 1 } }
    }
    ButtonTEST.x = 50
    ButtonTEST.y = drviceH - 40
    --ButtonTEST:setEnabled( false )
    --將透明度設為0就是隱藏物件
    ButtonTEST.alpha=0
    sceneGroup:insert(ButtonTEST)

    -- 按鈕，離開
    local ButtonExit = widget.newButton
    {
        label = "離開",
        labelColor = { default={ 0, 0, 0 } },
        fontSize = 20,
        onEvent = ButtonExit_Handle ,
        emboss = false,
        --properties for a rounded rectangle button...
        shape="circle",
        radius = 50,
        fillColor = { default={ 0.2, 0.5, 0.2, 1 }, over={ 0.3, 0.5, 0.3, 1 } }
    }
    ButtonExit.x = centerX 
    ButtonExit.y = centerY

    sceneGroup:insert(ButtonExit)

    -- 按鈕，九九乘法練習
    local ButtonLearn = widget.newButton
    {
        label = "九九乘法表",
        labelColor = { default={ 0, 0, 0 } },
        fontSize = 20,
        onEvent = ButtonLearn_Handle ,
        emboss = false,
        --properties for a rounded rectangle button...
        shape="roundedRect",
        width = 150,
        height = 60,
        cornerRadius = 10,
        fillColor = { default={ 0.6, 0.5, 0.2, 1 }, over={ 0.3, 0.8, 0.3, 1 } }
    }
    ButtonLearn.x = centerX - 130
    ButtonLearn.y = centerY - 50

    sceneGroup:insert(ButtonLearn)

    -- 按鈕，九九乘法練習
    local ButtonLearn1 = widget.newButton
    {
        label = "階梯式背誦",
        labelColor = { default={ 0, 0, 0 } },
        fontSize = 20,
        onEvent = ButtonLearn1_Handle ,
        emboss = false,
        --properties for a rounded rectangle button...
        shape="roundedRect",
        width = 150,
        height = 60,
        cornerRadius = 10,
        fillColor = { default={ 0.5, 0.5, 0.9, 1 }, over={ 0.3, 0.3, 0.9, 1 } }
    }
    ButtonLearn1.x = centerX - 130
    ButtonLearn1.y = centerY + 50

    sceneGroup:insert(ButtonLearn1)

     -- 按鈕，進階練習
    local ButtonGame1 = widget.newButton
    {
        label = "進階練習",
        labelColor = { default={ 0, 0, 0 } },
        fontSize = 20,
        onEvent = ButtonGame1_Handle ,
        emboss = false,
        --properties for a rounded rectangle button...
        shape="roundedRect",
        width = 150,
        height = 60,
        cornerRadius = 10,
        fillColor = { default={ 0.5, 0.9, 0.9, 1 }, over={ 0, 0.9, 0.9, 1 } }
    }
    ButtonGame1.x = centerX + 130
    ButtonGame1.y = centerY + 50

    sceneGroup:insert(ButtonGame1)

    -- 按鈕，基本練習
    local ButtonGame2 = widget.newButton
    {
        label = "基本練習",
        labelColor = { default={ 0, 0, 0 } },
        fontSize = 20,
        onEvent = ButtonGame2_Handle ,
        emboss = false,
        --properties for a rounded rectangle button...
        shape="roundedRect",
        width = 150,
        height = 60,
        cornerRadius = 10,
        fillColor = { default={ 0.9, 0.9, 0.5, 1 }, over={ 0.9, 0.9, 0.3, 1 } }
    }
    ButtonGame2.x = centerX + 130
    ButtonGame2.y = centerY - 50

    sceneGroup:insert(ButtonGame2)    

end --item:create End


function item:show(event)
    local phase = event.phase    
    if "did" == phase then
        composer.removeScene("learn")
        composer.removeScene("learn1")
        composer.removeScene("game1")
        composer.removeScene("game2")
        composer.removeScene("test")
    end 
end  -- item:show End

item:addEventListener( "create", item )
item:addEventListener( "show", item )


return item
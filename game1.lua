-- require controller module
local composer = require("composer")
local game1 = composer.newScene()

-- Load the widget
local widget = require("widget")


--中間點的座標
local centerX = display.contentCenterX
local centerY = display.contentCenterY

--螢幕的大小
local drviceW = display.contentWidth
local drviceH = display.contentHeight

--螢幕的大小
local screenX = display.contentWidth - (display.screenOriginX * 2 )
local screenY = display.contentHeight - (display.screenOriginY * 2 )

tbNumBtn = {}
gpNumBtn = display.newGroup()

tbRound = {
            {0,2,4,6,8,1,3,5,7,9},
            {0,4,5,6,1,9,2,7,3,8},
            {0,1,9,4,5,6,7,3,2,8},
            {0,8,4,6,1,3,5,2,9,7},
            {0,6,1,9,7,3,2,8,4,5}
          } --亂數表，第一個元素一定是0


scoreR = 0
scoreW = 0 


function ReturnText_Handle()
    composer.gotoScene( "item", "crossFade", 1000 )
end  -- ReturnText_Handle



function ButtonNum_Handle(event)
	local objNum = event.target
    if #answerText2.text < 2 then
    	--event.target.id表示目前執行event的物件id值
	    --a:setFillColor( 100, 0, 200 )
        local tmpNum = 0
        tmpNum = tonumber(answerText2.text) * 10 + objNum:getLabel()
        answerText2.text = tostring(tmpNum)
        --local alert = native.showAlert( "Debug", event.target:getLabel(), { "OK"} )
    else 
    	answerText2.text = objNum:getLabel()
    end  --#answerText2.text    	
end --ButtonNum_Handle End



function Question_Handle()
        a = math.random(9)  --乘數
        b = math.random(9)  --被乘數
        c = a * b  --答案
        tmpStr = table.concat({a," x " ,b," = "," ? "})
        queryText1.text= tmpStr
end  --Question_Handle



function ButtonClear_Handle() 
    answerText2.text = 0
end --ButtonClear_Handle



local function rightTime_Handle( event )
    ReturnText:addEventListener( "touch" ,ReturnText_Handle)
    tellmeText:addEventListener( "touch",tellmeText_Handle )
    ButtonClear:setEnabled( true )
    ButtonEnter:setEnabled( true )
    scoreR = scoreR + 1
    scoreRight.text=scoreR
    for i = 1,#tbNumBtn do
        tbNumBtn[i]:setEnabled(true)
    end
    if rightPNG then 
        rightPNG:removeSelf()
    end;
    answerText2.text = 0 
    Question_Handle()
end



local function wrongTime_Handle( event )
    ReturnText:addEventListener( "touch" ,ReturnText_Handle)
    tellmeText:addEventListener( "touch",tellmeText_Handle )
    ButtonClear:setEnabled( true )
    ButtonEnter:setEnabled( true )
    scoreW = scoreW + 1
    scoreWrong.text=scoreW 
    for i = 1,#tbNumBtn do
        tbNumBtn[i]:setEnabled(true)
    end
    if wrongPNG then 
        wrongPNG:removeSelf()
    end
    answerText2.text = 0 
end



function ButtonEnter_Handle()
    ReturnText:removeEventListener( "touch" ,ReturnText_Handle)
    tellmeText:removeEventListener( "touch",tellmeText_Handle )
    ButtonClear:setEnabled( false )
    ButtonEnter:setEnabled( false )
    for i = 1,#tbNumBtn do
        tbNumBtn[i]:setEnabled(false)
    end    

    if tonumber(answerText2.text) == c then
    	--local alert = native.showAlert( "Debug", "答對了", { "OK"} )
        rightPNG = display.newImage("right.png")
        rightPNG.x = drviceW - 70
        rightPNG.y = 100
        rightPNG:scale( 0.7, 0.7 )
        sceneGroup:insert(rightPNG)
        timer1 = timer.performWithDelay( 500, rightTime_Handle )  -- wait 0.5 seconds
    else
        --local alert = native.showAlert( "Debug", "再想一想。", { "OK"} )
        --答錯的圖片
        wrongPNG = display.newImage("wrong.png")
        wrongPNG.x = drviceW - 70
        wrongPNG.y = 100
        wrongPNG:scale( 0.7, 0.7 ) --圖片大小（比例） 
        sceneGroup:insert(wrongPNG)    
        timer1 = timer.performWithDelay( 500, wrongTime_Handle )  -- wait 0.5 seconds 
    end 
    recoveryNum_Handle()
end --ButtonEnter_Handle



--更改數字盤為提示數字
function tellmeText_Handle(e)
	if e.phase == "ended"  or e == "ended" then 
        local tmpR = math.random(3)
        for i = 1,#tbNumBtn do 
            tbNumBtn[i]:setLabel(a * tonumber(tbRound[tmpR][i]))
        end
    end
end  --tellmeText_Handle



--還原數字盤數字
function recoveryNum_Handle()
    local tmpR = math.random(3)
    for i = 1,#tbNumBtn do 
        tbNumBtn[i]:setLabel(i-1)
    end
end 



function game1:create(event)
    sceneGroup = self.view  
    
    --背景圖片
    local GLpngbg = display.newImageRect( "png01.png",screenX,screenY )
    GLpngbg.x=centerX
    GLpngbg.y=centerY
    --GLpngbg:scale( 0.9, 1 )
    sceneGroup:insert(GLpngbg)

    scoreRightText = display.newText("答對：",drviceW - 120,50,native.systemFont,25 )
    scoreRightText:setFillColor( 0, 0, 0)
    sceneGroup:insert(scoreRightText)
    scoreRight = display.newText(scoreR,drviceW - 60,50,native.systemFont,25 )
    scoreRight:setFillColor( 0, 0, 0)
    sceneGroup:insert(scoreRight)
    scoreWrongText = display.newText("答錯：",drviceW - 120,100,native.systemFont,25 )
    scoreWrongText:setFillColor( 0, 0, 0)
    sceneGroup:insert(scoreWrongText)
    scoreWrong = display.newText(scoreW,drviceW - 60,100,native.systemFont,25 )
    scoreWrong:setFillColor( 0, 0, 0)
    sceneGroup:insert(scoreWrong)  
   
    --數字盤背景
    --bgRoundedRect = display.newRect( (drviceW / 2), (drviceH - drviceH / 5), drviceW,(drviceH / 2)+40 )
    --bgRoundedRect.strokeWidth = 2
    --bgRoundedRect:setFillColor( 0.5, 0.6, 0.5)
    --bgRoundedRect:setStrokeColor( 0, 0, 0 )
    --gpNumBtn:insert(bgRoundedRect)

    -- 按鈕，1~9
    local i = 0
    local BaseStartX = 40
    local BaseStartY = 40
    for i =0,9 do 
    	ButtonNum = widget.newButton
        {
            label = i,
            labelColor = { default={ 0, 0, 0 } },
            fontSize = 25,
            --onEvent = ButtonNum_Handle,
            onRelease = ButtonNum_Handle,
            emboss = false,
            shape="Rect",
            strokeColor = { default={ 0.4, 0.4, 0.1 }, over={  0.4, 0.4, 0.1 } },
            strokeWidth = 2,
            width =  50,
            height = 50,
            --cornerRadius = 5,
            fillColor = { default={ 0.8, 0.8, 0.4, 1 }, over={ 0.3, 1, 0.3, 1 } },
            id = i  --可以做為event值的判斷
        }
        if i <= 4 then
            ButtonNum.x = BaseStartX  + i * 50 
            ButtonNum.y = drviceH - (BaseStartY + 50 + 25)
        else
        	ButtonNum.x = BaseStartX  + (i-5) * 50 
          	ButtonNum.y = drviceH - (BaseStartY + 25)
        end --if i End     

        table.insert(tbNumBtn,ButtonNum)
         
        gpNumBtn:insert(ButtonNum)       
        
    end --for i= 1,9 End

    --清除鍵與確認鍵
    ButtonClear = widget.newButton
    {
        label = "清除",
        labelColor = { default={ 0, 0, 0 } },
        fontSize = 25,
        --onEvent = ButtonNum_Handle,
        onRelease = ButtonClear_Handle,
        emboss = false,
        shape="Rect",
        strokeColor = { default={  0.4, 0.4, 0.1}, over={  0.4, 0.4, 0.1 } },
        strokeWidth = 2,
        width =  80,
        height = 50,
        --cornerRadius = 5,
        fillColor = { default={0.8, 0.5, 0.2, 1 }, over={ 0.3, 1, 0.3, 1 } },
        id = i  --可以做為event值的判斷
    }
    ButtonClear.x = BaseStartX  + 4 * 50 + 65
    ButtonClear.y = drviceH - (BaseStartY + 50 + 25)
    gpNumBtn:insert(ButtonClear)      

    ButtonEnter = widget.newButton
    {
        label = "確定",
        labelColor = { default={ 0, 0, 0 } },
        fontSize = 25,
        --onEvent = ButtonNum_Handle,
        onRelease = ButtonEnter_Handle,
        emboss = false,
        shape="Rect",
        strokeColor = { default={  0.4, 0.4, 0.1 }, over={  0.4, 0.4, 0.1 } },
        strokeWidth = 2,
        width =  80,
        height = 50,
        --cornerRadius = 5,
        fillColor = { default={0.8, 0.5, 0.2, 1 }, over={ 0.3, 1, 0.3, 1 } },
        id = i  --可以做為event值的判斷
    }
    ButtonEnter.x = BaseStartX  + 4 * 50 + 65
    ButtonEnter.y = drviceH - (BaseStartY + 25)
    gpNumBtn:insert(ButtonEnter) 

    sceneGroup:insert(gpNumBtn)

    ReturnText = display.newText("返回",drviceW - 30,drviceH - 50,native.systemFont,25 )
    ReturnText:setFillColor( 0, 0, 0)
    sceneGroup:insert(ReturnText)
    ReturnText:addEventListener( "touch", ReturnText_Handle )

    tellmeText = display.newText("提示",drviceW - 30,drviceH - 100,native.systemFont,25 )
    tellmeText:setFillColor( 0, 0, 0)
    sceneGroup:insert(tellmeText)
    tellmeText:addEventListener( "touch", tellmeText_Handle )

    queryText1 = display.newText("0 x 0 = ?",150,50,native.systemFont,50 )
    queryText1:setFillColor( 0.3, 0.2, 1 )
    sceneGroup:insert(queryText1)
    --queryText:addEventListener( "touch", ReturnText_Handle )

    local answerText1 = display.newText("答案：",110,120,native.systemFont,40 )
    answerText1:setFillColor( 0.3, 0.2, 1 )
    sceneGroup:insert(answerText1)

    answerText2 = display.newText("0",200,120,native.systemFont,40 )
    answerText2:setFillColor( 0.3, 0.2, 1 )
    sceneGroup:insert(answerText2)

    Question_Handle()

end --learn:create Ene



function game1:show(event)
    local phase = event.phase    
    if "did" == phase then
        -- remove previous scene's view
        composer.removeScene("item")
    end 
end --ten:show End



game1:addEventListener( "create", game1 )
game1:addEventListener( "show", game1 )


return game1
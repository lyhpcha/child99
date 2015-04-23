-- require controller module
local composer = require("composer")
local game2 = composer.newScene()

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

tbNumBtn1 = {}
gpNumBtn1 = display.newGroup()

tbRound = {
            {0,2,4,6,8,1,3,5,7,9},
            {0,4,5,6,1,9,2,7,3,8},
            {0,1,9,4,5,6,7,3,2,8},
            {0,8,4,6,1,3,5,2,9,7},
            {0,6,1,9,7,3,2,8,4,5},
            {0,3,2,8,4,5,6,1,9,7}
          } --亂數表，第一個元素一定是0

a = 1
b = 0

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
        if b == 9 then
            b = 0 
        end 
        b = b + 1  --被乘數
        c = a * b  --答案
        tmpStr = table.concat({a," x " ,b," = "," ? "})
        queryText1.text= tmpStr
end  --Question_Handle



function ButtonClear_Handle() 
    answerText2.text = 0
end --ButtonClear_Handle


function AnswerCreate_Handle()
    local z = math.random(6)
    for i = 1,#tbNumBtn do
            --local alert = native.showAlert( "Debug", a, { "OK"} )
            tbNumBtn[i]:setLabel(a * tonumber(tbRound[z][i]))
    end
end --AnswerCreate_Handle  



local function rightTime_Handle( event )
    ReturnText:addEventListener( "touch" ,ReturnText_Handle)
    changeText:addEventListener( "touch",changeText_Handle )
    ButtonClear:setEnabled( true )
    ButtonEnter:setEnabled( true )
    scoreR = scoreR + 1
    scoreRight.text = scoreR
    for i = 1,#tbNumBtn do
        tbNumBtn[i]:setEnabled(true)
    end
    if rightPNG then 
        rightPNG:removeSelf()
    end 
    answerText2.text = 0 
    AnswerCreate_Handle()
    Question_Handle()
end



local function wrongTime_Handle( event )
    ReturnText:addEventListener( "touch" ,ReturnText_Handle)
    changeText:addEventListener( "touch",changeText_Handle )
    ButtonClear:setEnabled( true )
    ButtonEnter:setEnabled( true )
    scoreW = scoreW + 1
    scoreWrong.text = scoreW
    for i = 1,#tbNumBtn do
        tbNumBtn[i]:setEnabled(true)
    end
    if wrongPNG then 
        wrongPNG:removeSelf()
    end 
    AnswerCreate_Handle()
    answerText2.text = 0 
end



function ButtonEnter_Handle()

    ReturnText:removeEventListener( "touch" ,ReturnText_Handle)
    changeText:removeEventListener( "touch",changeText_Handle )
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
end --ButtonEnter_Handle



function bgRect_Handle_End(event)
    a = event.target.id
    AnswerCreate_Handle()
    b = 0 
    bgRect:removeSelf()
    choiceText:removeSelf( )
    if ButtonNum1 then
        for i = #tbNumBtn1, 1, -1 do
            local child = table.remove(tbNumBtn1, i)    -- Remove from table
            if child ~= nil then  --判斷是否為Null
                child:removeSelf()
                child = nil
            end
        end 
    end

    --恢復事件監聽
    ReturnText:addEventListener( "touch" ,ReturnText_Handle)
    changeText:addEventListener( "touch",changeText_Handle )
    ButtonClear:setEnabled( true )
    ButtonEnter:setEnabled( true )
    for i = 1,#tbNumBtn do
        tbNumBtn[i]:setEnabled(true)
    end
    Question_Handle()
end  --bgRect_Handle_End



function beRect_Handle_Start()
    local i = 0
    if ReturnText then
        ReturnText:removeEventListener( "touch" ,ReturnText_Handle)
    end 
    if changeText then
        changeText:removeEventListener( "touch",changeText_Handle )
    end 
    if ButtonClear then 
        ButtonClear:setEnabled( false )
    end
    if ButtonEnter then
        ButtonEnter:setEnabled( false )
    end 
    if ButtonNum then 
        for i = 1,#tbNumBtn do
            tbNumBtn[i]:setEnabled(false)
        end
    end 
    --bgRect = display.newRect(0,0,drviceW,drviceH)
    bgRect = display.newRect(0,0,screenX,screenY)
    bgRect:setFillColor(0.4, 0.6, 0.4)
    bgRect.alpha=1
    bgRect.x=centerX
    bgRect.y=centerY
    sceneGroup:insert(bgRect) 

    choiceText = display.newText("請選擇乘數",centerX,centerY,native.systemFont,35 )
    choiceText:setFillColor( 0.4, 0.2, 0.4)
    sceneGroup:insert(choiceText)

    -- 按鈕，1~9
    i = 0
    local BaseStartX = 40
    local BaseStartY = 100
    for i =1,9 do 
        ButtonNum1 = widget.newButton
        {
            label = i,
            labelColor = { default={ 0, 0, 0 } },
            fontSize = 25,
            --onEvent = ButtonNum_Handle,
            onRelease = bgRect_Handle_End,
            emboss = false,
            --shape="Rect",
            shape = "circle",
            radius = 25,
            --strokeColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },
            --strokeWidth = 2,
            width =  60,
            height = 60,
            --cornerRadius = 5,
            fillColor = { default={ 0.2, 0.9, 0.8, 1 }, over={ 0.3, 1, 0.3, 1 } },
            id = i  --可以做為event值的判斷
        }
        --ButtonNum1.x = BaseStartX  + (i-1) * 50 
        --ButtonNum1.y = drviceH - (BaseStartY)
        --ButtonNum1.x = centerX +  math.cos(40*i*math.pi/180)*160
        --ButtonNum1.y = centerY +  math.sin(40*i*math.pi/180)*100
        if i < 5 then 
            ButtonNum1.x = 0 
            ButtonNum1.y = 0
            transition.to( ButtonNum1, { time=500, x=(centerX + math.cos(40*i*math.pi/180)*160), y=(centerY +  math.sin(40*i*math.pi/180)*100) } )
        else 
            ButtonNum1.x = drviceW 
            ButtonNum1.y = drviceH
            transition.to( ButtonNum1, { time=500, x=(centerX + math.cos(40*i*math.pi/180)*160), y=(centerY +  math.sin(40*i*math.pi/180)*100) } )
        end 
        
        table.insert(tbNumBtn1,ButtonNum1)
        sceneGroup:insert(ButtonNum1)
    end --for i= 1,9 End
   
end --beRect_Handle_Start



function changeText_Handle()
    beRect_Handle_Start()
end --changeText_Handle



function game2:create(event)
    sceneGroup = self.view 

    --背景圖片
    local GLpngbg = display.newImageRect( "png01.png",screenX,screenY )
    GLpngbg.x=centerX
    GLpngbg.y=centerY
    --GLpngbg:scale( 0.9, 1 )
    sceneGroup:insert(GLpngbg)   
   
    --數字盤背景
    --bgRoundedRect = display.newRect( (drviceW / 2), (drviceH - drviceH / 5), drviceW,(drviceH / 2)+40 )
    --bgRoundedRect.strokeWidth = 2
    --bgRoundedRect:setFillColor( 0.5, 0.7, 0.5)
    --bgRoundedRect:setStrokeColor( 0, 0, 0 )
    --gpNumBtn:insert(bgRoundedRect)
    
    -- 選擇按鈕，1~9
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
            strokeColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },
            strokeWidth = 2,
            width =  50,
            height = 50,
            --cornerRadius = 5,
            fillColor = { default={ 0.6, 0.5, 0.6, 1 }, over={ 0.1, 0.6, 0.4, 1 } },
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
        onRelease = ButtonClear_Handle,
        emboss = false,
        shape="Rect",
        strokeColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },
        strokeWidth = 2,
        width =  80,
        height = 50,
        --cornerRadius = 5,
        fillColor = { default={ 0.2, 0.6, 0.6, 1}, over={ 0.3, 1, 0.3, 1 } },
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
        strokeColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },
        strokeWidth = 2,
        width =  80,
        height = 50,
        --cornerRadius = 5,
        fillColor = { default={ 0.2, 0.6, 0.6, 1}, over={ 0.3, 1, 0.3, 1 } },
        id = i  --可以做為event值的判斷
    }
    ButtonEnter.x = BaseStartX  + 4 * 50 + 65
    ButtonEnter.y = drviceH - (BaseStartY + 25)
    gpNumBtn:insert(ButtonEnter) 

    sceneGroup:insert(gpNumBtn)

    --遮罩測試---------------------------------------------------TESTING
    --local mask = graphics.newMask("a.png")  --設定遮罩物件
    --local bgRect = display.newRect(0,0,100,100)
    --bgRect.x = centerX
    --bgRect.y = centerY
    --bgRect.alpha=0.5
    --sceneGroup:insert(bgRect)
    --local mask = graphics.newMask( bgRect)
    --gpNumBtn:setMask(mask) --設定遮罩
    --gpNumBtn:setMask(nil)  --解除遮罩

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

    ReturnText = display.newText("返回",drviceW - 30,drviceH - 50,native.systemFont,25 )
    ReturnText:setFillColor( 0, 0, 0)
    sceneGroup:insert(ReturnText)
    ReturnText:addEventListener( "touch", ReturnText_Handle )

    changeText = display.newText("重選乘數",drviceW - 55,drviceH - 100,native.systemFont,25 )
    changeText:setFillColor( 0, 0, 0)
    sceneGroup:insert(changeText)
    changeText:addEventListener( "touch", changeText_Handle )

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

    beRect_Handle_Start()

    --Question_Handle()
end --learn:create Ene



function game2:show(event)
    local phase = event.phase    
    if "did" == phase then
        -- remove previous scene's view
        composer.removeScene("item")
    end 
end --ten:show End



game2:addEventListener( "create", game2 )
game2:addEventListener( "show", game2 )



return game2
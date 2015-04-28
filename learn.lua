-- 九九乘法

local composer = require( "composer" )
local learn = composer.newScene()

-- Load the widget
local widget = require( "widget" )

-- Hide the status bar.
display.setStatusBar(display.HiddenStatusBar)

--中間點的座標
local centerX = display.contentCenterX
local centerY = display.contentCenterY

--螢幕的大小
local drviceW = display.contentWidth
local drviceH = display.contentHeight

--實際畫面的大小
local screenX = display.contentWidth - (display.screenOriginX * 2 )
local screenY = display.contentHeight - (display.screenOriginY * 2 )


tGroup1 = {}


--數學題目，傳入2~9的被乘數，無圖片 
function question1_Handle(a)

    local baseX = 140
    local baseY = 20 

    --清除原有資料
    if tGroup1[1] then
        for i = #tGroup1, 1, -1 do
            local child = table.remove(tGroup1, i)    -- Remove from table
            if child ~= nil then  --判斷是否為Null
                child:removeSelf()
                child = nil
            end
        end 
    end

    for b=1,9 do
        local c1 = a * b
        local Tmp1 = a .. " x " .. b .. " = " .. c1 --字串相加
        local c2 = (a + 1) * b
        local Tmp2 = (a + 1) .. " x " .. b .. " = " .. c2

        if c1 < 10 then
            local myText1 = display.newText(Tmp1,baseX,baseY + (b * 27 ),native.systemFont,25 )
            myText1:setFillColor( 1, 1, 1 )
            sceneGroup:insert(myText1)
            table.insert(tGroup1,myText1)
        else
            local myText1 = display.newText(Tmp1,baseX + 5,baseY + (b * 27 ),native.systemFont,25 )            
            myText1:setFillColor( 1, 1, 1 )
            sceneGroup:insert(myText1)
            table.insert(tGroup1,myText1)
        end --if c1 < 10 

        if c2 < 10 then
            local myText2 = display.newText(Tmp2,(baseX + 180),baseY + (b * 27 ),native.systemFont,25 )
            myText2:setFillColor( 1, 1, 1 )
            sceneGroup:insert(myText2)
            table.insert(tGroup1,myText2)
        else
            local myText2 = display.newText(Tmp2,(baseX + 180 + 5),baseY + (b * 27 ),native.systemFont,25 )            
            myText2:setFillColor( 1, 1, 1 )
            sceneGroup:insert(myText2)
            table.insert(tGroup1,myText2)
        
        end --if c2 < 10 
    end
end -- question1_Handle



function BackText_Handle(e) 
    if e.phase == "ended"  or e == "ended" then 
        if (globalNum > 3) then 
            globalNum = globalNum - 2
         elseif globalNum == 2 then
            globalNum = 8
        else 
            globalNum =2
        end --(globalNum <3)
        question1_Handle(globalNum)
    end --e.phase
end  -- BackImag_Handle



function NextText_Handle(e) 
    if e.phase == "ended"  or e == "ended" then 
        if (globalNum < 7) then 
            globalNum = globalNum + 2
        elseif globalNum == 8 then
            globalNum = 2
        else
            globalNum = 8
        end --(globalNum <3)
        question1_Handle(globalNum)
    end --e.phase
end  -- BackImag_Handle



function ReturnText_Handle()
    composer.gotoScene( "item", "crossFade", 1000 )
end



function learn:create(event)
    sceneGroup = self.view    

    --背景圖片
    local GLpngbg = display.newImageRect( "png01.png",screenX,screenY )
    GLpngbg.x=centerX
    GLpngbg.y=centerY
    --GLpngbg:scale( 0.9, 1 )
    sceneGroup:insert(GLpngbg)

    globalNum = 2 
    question1_Handle(globalNum)
    
    --local BackText = display.newText("<",30,centerY,native.systemFont,60 )
    --BackText:setFillColor( 0.3, 0.2, 1 )
    BackPng = display.newImage("arrow_button2.png")
    BackPng.x = 40
    BackPng.y = centerY
    BackPng:scale(0.5,0.5)
    sceneGroup:insert(BackPng)
    BackPng:addEventListener( "touch", BackText_Handle )

    NextPng = display.newImage("arrow_button.png")
    NextPng.x = drviceW - 40
    NextPng.y = centerY
    NextPng:scale(0.5,0.5)
    sceneGroup:insert(NextPng)
    NextPng:addEventListener( "touch", NextText_Handle )    

    local ReturnText = display.newText("返回",drviceW - 30,drviceH - 50,native.systemFont,25 )
    ReturnText:setFillColor( 1, 1, 1 )
    sceneGroup:insert(ReturnText)
    ReturnText:addEventListener( "touch", ReturnText_Handle )

end --learn:create Ene



function learn:show(event)
    local phase = event.phase    
    if "did" == phase then
        -- remove previous scene's view
        composer.removeScene("item")
    end 
end --ten:show End


learn:addEventListener( "create", learn )
learn:addEventListener( "show", learn )


return learn
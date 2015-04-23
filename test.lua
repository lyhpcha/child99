-- require controller module
local composer = require("composer")
local test = composer.newScene()

-- Load the widget
local widget = require("widget")

--中間點的座標
local centerX = display.contentCenterX
local centerY = display.contentCenterY

--螢幕的大小
local drviceW = display.contentWidth
local drviceH = display.contentHeight

local physics = require "physics"

function ReturnText_Handle()
    Runtime:removeEventListener( "enterFrame", Start_Handle)  --移除enterFrame Listener
    composer.gotoScene( "item", "crossFade", 1000 )
end


function Start_Handle(event) 
    if rotationNum == -360 then 
        rotationNum = 0 
    end
    myRectangle.rotation = myRectangle.rotation -10
    --rotationNum = rotationNum - 0.2
    rotationNum = rotationNum - 5
    --[[
    myCircle1.x = myCircle.x + math.cos(rotationNum*-1*math.pi/180)*30 
    myCircle1.y = myCircle.y + math.sin(rotationNum*-1*math.pi/180)*30 
    myCircle2.x = myCircle.x + math.cos((rotationNum-90)*-1*math.pi/180)*30 
    myCircle2.y = myCircle.y + math.sin((rotationNum-90)*-1*math.pi/180)*30 
    myCircle3.x = myCircle.x + math.cos((rotationNum-180)*-1*math.pi/180)*30 
    myCircle3.y = myCircle.y + math.sin((rotationNum-180)*-1*math.pi/180)*30 
    myCircle4.x = myCircle.x + math.cos((rotationNum-270)*-1*math.pi/180)*30 
    myCircle4.y = myCircle.y + math.sin((rotationNum-270)*-1*math.pi/180)*30 ]]

    
    group1.x=centerX
    group1.y=centerY
    
    --Graphics 2.0 已不支援setReferencePoint，改用anchorX、anchorY
    --group1:setReferencePoint(display.CenterReferencePoint)

    --Group要先設定anchorChildren為true，才能設定錨點的位置
    group1.anchorChildren = true
    group1.anchorX = 0.1
    group1.anchorY = 0.1

    group1.rotation = group1.rotation -10

end


function test:create( event )
    local sceneGroup = self.view


    local aa  = display.newRect( 0, 0, 50, 50 )
    aa.strokeWidth = 3
    aa.x = 50
    aa.y = 150 
    aa:setFillColor( 0.9,1,0.9 )
    aa:setStrokeColor( 0.2, 1, 0.2 )
    local bb  = display.newRect( 0, 0, 70, 50 )
    bb.strokeWidth = 3
    bb.x = 200
    bb.y = 100 
    bb:setFillColor( 0.7,1,0.7)
    bb:setStrokeColor( 0.2, 1, 0.2 )
    local cc  = display.newRect( 0, 0, 50, 50 )
    cc.strokeWidth = 3
    cc.x = 300
    cc.y = 100 
    cc:setFillColor( 0.7,1,0.7)
    cc:setStrokeColor( 0.2, 1, 0.2 )
    local dd  = display.newRect( 0, 0, drviceW, 50 )
    dd.strokeWidth = 3
    dd.x = centerX
    dd.y = drviceH - 30 
    dd:setFillColor( 0.7,1,0.7)
    dd:setStrokeColor( 0.2, 1, 0.2 )
    physics.start()
    physics.addBody( dd,"static")
    physics.addBody( aa,"static")
    physics.addBody( bb,{bounce=0.9})
    physics.addBody( cc,{bounce=0.7})
    local pivotJoint = physics.newJoint( "pivot", aa, bb, aa.x, aa.y)
    local pivoJoint1 = physics.newJoint("pivot", bb,cc,bb.x,bb.y)
    --physics.stop()
    --pivotJoint.isLimitEnabled = true
    --pivotJoint:setRotationLimits( -20, 20 )

    --transition.to( aa, { time=500, x=250, y=280} )

    rotationNum = 0

    local ReturnText = display.newText("返回",50,50,native.systemFont,25 )
    ReturnText:setFillColor( 0.3, 0.2, 1 )
    sceneGroup:insert(ReturnText)
    ReturnText:addEventListener( "touch", ReturnText_Handle )
    
    myRectangle = display.newRect( 0, 0, 100, 50 )
    myRectangle.strokeWidth = 3
    myRectangle.x = 150
    myRectangle.y = 100 
    myRectangle:setFillColor( 0.9,1,0.9 )
    myRectangle:setStrokeColor( 0.2, 1, 0.2 )

    --sceneGroup:insert(myRectangle)

    testText1 = display.newText("測試",150,100,native.systemFont,25 )
    testText1:setFillColor( 0, 0, 0 )
    --sceneGroup:insert(testText1)

    group = display.newGroup()
    group:insert(myRectangle)
    group:insert( testText1 )

    sceneGroup:insert( group )

    --transition.to( group, { time=1500, alpha=1, x=250, y=150,transition=easing.outlnCubic } )
    --transition.blink( group, { time=1000 } )
    
    --transition.fadeIn( testText1, { x=50, y=200,time=2000 } )   
    --transition.fadeIn( testText1, { x=50, y=200,time=2000 } )  

    group1 = display.newGroup()

    myCircle = display.newCircle( 250, 150, 30 )
    myCircle:setFillColor( 0,0,1 )
    sceneGroup:insert( myCircle )
    group1:insert( myCircle)

    myCircle1 = display.newCircle( 280, 150, 10 )
    myCircle1:setFillColor( 0,1,0 )
    sceneGroup:insert( myCircle1 )
    group1:insert( myCircle1)
    

    myCircle2 = display.newCircle( 250, 180, 10 )
    myCircle2:setFillColor( 1,1,0.2 )
    sceneGroup:insert( myCircle2 )
    group1:insert( myCircle2)

    myCircle3 = display.newCircle( 220, 150, 10 )
    myCircle3:setFillColor( 1,0.5,0.2 )
    sceneGroup:insert( myCircle3 )
    group1:insert( myCircle3)

    myCircle4 = display.newCircle( 250, 120, 10 )
    myCircle4:setFillColor( 0.3,0.8,0.3 )
    sceneGroup:insert( myCircle4 )
    group1:insert( myCircle4)
 
end 



function test:show(event)
    local phase = event.phase    
    if "did" == phase then
        -- remove previous scene's view
        composer.removeScene("item")
    end 
end --ten:show End



test:addEventListener( "create", test )
test:addEventListener( "show", test )
Runtime:addEventListener( "enterFrame", Start_Handle)


return test
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local fisica = require( "physics" )
fisica.start()
fisica.setGravity(0, 9.8)


function display:tap (event)
	if (event.x > display.contentWidth/2) then
		transition.to( walter, {time=350, x = walter.x+155, y = walter.y -100} )
		audio.play ( somPulo )

		tapHere.x = centerX - 250
	end

	if (event.x < display.contentWidth/2) then
		transition.to( miriam, {time=350, x = miriam.x-155, y = miriam.y -100} )
		adicionarCorpoFisica(miriam)
		audio.play ( somPulo )
	end
end


function adicionarCorpoFisica(obj)
	fisica.addBody(obj, "dynamic")
end

local widget = require( "widget" )


-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	-- CREATE display objects and add them to 'group' here.
	-- Example use-case: Restore 'group' from previously saved state.

	--menu_song = audio.loadStream( "Move Forward.mp3" )

	--audio.play(menu_song)

	chao = display.newRect(0, display.contentHeight, display.contentWidth*2, 100)
	chao.myName = "chao"
	group:insert(chao)
	fisica.addBody(chao, "kinematic", {isSensor=true})

	local background = display.newImageRect( "fundo_instrucoes.png", (display.contentWidth - display.screenOriginX)-display.screenOriginX, (display.contentHeight - display.screenOriginY)-display.screenOriginY+250 )
	background.x = display.contentWidth*0.5
	background.y = display.contentHeight*0.5
	group:insert( background )

		--FONTE 
	if "Win" == system.getInfo( "platformName" ) then 
		fonte = "Nosifer-Regular" 
	elseif "Android" == system.getInfo( "platformName" ) then 
		fonte = "Nosifer-Regular" 
	end
	
	local plataforma1 = display.newImageRect( "plataforma.png", 150, 30 )
	plataforma1.x = centerX
	plataforma1.y = centerY+(display.contentHeight -400 )
	fisica.addBody(plataforma1, "static")
	group:insert(plataforma1)

	walter = display.newImageRect( "zumbi.png", 80, 80 )
	walter.x = centerX
	walter.y = centerY+(display.contentHeight -400 )
	walter.myName = "walter"
	fisica.addBody(walter, "dynamic")
	group:insert(walter)

	tapHere = display.newImageRect( "tap.png", 200, 60 )
	tapHere.x = centerX + 250
	tapHere.y = centerY - 100
	group:insert(tapHere)

end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view



	local function destaca()

		if tapHere.alpha == 0 then
			tapHere.alpha = 1
		else
			tapHere.alpha = 0
		end

	end

	miriam = display.newImageRect( "miriam.png", 80, 80 )
	miriam.y = 1000

	local function onCollisionVoltaWalter (event)
		if event.object1.myName == "walter" and event.object2.myName == "chao" or event.object1.myName == "chao" and event.object2.myName == "walter" then
			
			miriam.x = centerX
			miriam.y = centerY+(display.contentHeight -450 )
			miriam.myName = "miriam"
			--fisica.addBody(miriam, "dynamic")
			group:insert(miriam)
		end
		if event.object1.myName == "miriam" and event.object2.myName == "chao" or event.object1.myName == "chao" and event.object2.myName == "miriam" then
			storyboard.gotoScene (  "escolherpersonagem", {effect = "slideUp"} )
		end
	end

	destacaDireito = timer.performWithDelay(500, destaca,0)

	Runtime:addEventListener( "tap", display )
	Runtime:addEventListener( "collision", onCollisionVoltaWalter )
	--Runtime:addEventListener( "tap", displayEsquerda )

	-- INSERT code here (e.g. start timers, load audio, start listeners, etc.)

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view

	--audio.pause( menu_song )

	Runtime:removeEventListener( "tap", display )
	Runtime:removeEventListener( "collision", onCollisionVoltaWalter )
	--Runtime:removeEventListener( "tap", displayEsquerda )

	-- INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	-- Remove listeners attached to the Runtime, timers, transitions, audio tracks

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view

	-- INSERT code here (e.g. remove listeners, widgets, save state, etc.)
	-- Remove listeners attached to the Runtime, timers, transitions, audio tracks

end



---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )


---------------------------------------------------------------------------------

return scene
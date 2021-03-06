local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- local forward references should go here --



local widget = require( "widget" )

local function buttonHit(event)
	storyboard.gotoScene (  event.target.destination, {effect = event.target.effect} )
	return true
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	local background = display.newImageRect( "background_menu.png", (display.contentWidth - display.screenOriginX)-display.screenOriginX, (display.contentHeight - display.screenOriginY)-display.screenOriginY+250 )
	background.x = display.contentWidth*0.5
	background.y = display.contentHeight*0.5
	group:insert( background )

	-- CREATE display objects and add them to 'group' here.
	-- Example use-case: Restore 'group' from previously saved state.

	menu_song = audio.loadStream( "Move Forward.mp3" )

	audio.play( menu_song )


	--FONTE 
	if "Win" == system.getInfo( "platformName" ) then 
		fonte = "Nosifer-Regular" 
	elseif "Android" == system.getInfo( "platformName" ) then 
		fonte = "Nosifer-Regular" 
	end


	local playBtn = widget.newButton
	{
		defaultFile = "Play.png",
		overFile = "Play2.png",
		--label = "Start",
		labelColor = 
		{ 
			default = { 51, 51, 51, 255 },
		},
		fontSize = 22,
		emboss = true,
		onPress = button1Press,
		onRelease = button1Release,
		x = centerX-(centerX*0.5-80),
		y = centerY-(centerY*0.5),
	}
	playBtn.destination = "instrucoesUm"
	playBtn.effect = "crossFade"
	playBtn:addEventListener("tap", buttonHit)
	group:insert(playBtn)


	local creditsBtn = widget.newButton
	{
		defaultFile = "buttonBlue.png",
		overFile = "buttonBlueOver.png",
		label = "Credits",
		labelColor = 
		{ 
			default = { 51, 51, 51, 255 },
		},
		fontSize = 22,
		emboss = true,
		onPress = button1Press,
		onRelease = button1Release,
		x = centerX+(centerX*0.5+80),
		y = centerY+250,
	}
	creditsBtn.destination = "gamecredits"
	creditsBtn.effect = "slideUp"
	creditsBtn:addEventListener("tap", buttonHit)
	group:insert(creditsBtn)
	
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view

	storyboard.purgeScene("play")

	-- INSERT code here (e.g. start timers, load audio, start listeners, etc.)

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view

	--audio.pause(menu_song)

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
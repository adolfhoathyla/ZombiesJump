local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- local forward references should go here --

main_song = audio.loadStream( "main_music_zj.mp3" )

local widget = require( "widget" )

local function buttonHit(event)
	storyboard.gotoScene (  event.target.destination, {effect = "slideDown"} )
	return true
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	-- CREATE display objects and add them to 'group' here.
	-- Example use-case: Restore 'group' from previously saved state.

	menu_song = audio.loadStream( "8bit Dungeon Boss.mp3" )

	audio.play( menu_song )


	--FONTE 
	if "Win" == system.getInfo( "platformName" ) then 
		fonte = "Nosifer-Regular" 
	elseif "Android" == system.getInfo( "platformName" ) then 
		fonte = "Nosifer-Regular" 
	end

	
	local title = display.newText( "Zombie's Jump", 0, 0, fonte, 38 )
	title.x = centerX
	title.y = display.screenOriginY + 40
	title:setFillColor( 255, 255, 255 )
	group:insert(title)

	local playBtn = widget.newButton
	{
		defaultFile = "buttonRed.png",
		overFile = "buttonRedOver.png",
		label = "Start",
		labelColor = 
		{ 
			default = { 51, 51, 51, 255 },
		},
		fontSize = 22,
		emboss = true,
		onPress = button1Press,
		onRelease = button1Release,
		x = centerX,
		y = centerY,
	}
	playBtn.destination = "play"
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
		x = centerX,
		y = centerY+80,
	}
	creditsBtn.destination = "gamecredits"
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

	audio.pause(menu_song)

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
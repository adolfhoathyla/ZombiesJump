local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local widget = require( "widget" )

function scene:createScene( event )
  --print("Estou createScene gameOver")
    local group = self.view

		--FONTE 
	if "Win" == system.getInfo( "platformName" ) then 
		fonte = "Nosifer-Regular" 
	elseif "Android" == system.getInfo( "platformName" ) then 
		fonte = "Nosifer-Regular" 
	end

	transition.pause()

	life:removeSelf( )

	local gameOver = display.newImageRect( "gameover.png", 500, 150 )
	gameOver.x = display.contentWidth*0.5
	gameOver.y = display.contentHeight*0.5
	group:insert(gameOver)

	local finalScore = display.newText( "Score: " .. score, 250, 50, fonte, 50 )
	finalScore.x = display.contentWidth*0.5
	finalScore.y = (display.contentHeight*0.5)+150
	group:insert(finalScore)

	messageScore:removeSelf( )
	audio.pause(main_song)
	audio.pause( somPulo )
	audio.pause( somComerCerebro )



	local restartBtn = widget.newButton
	{
		defaultFile = "buttonBlue.png",
		overFile = "buttonBlueOver.png",
		label = "Play Again",
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
	restartBtn.destination = "play"
	restartBtn:addEventListener("tap", buttonHit)
	--group:insert(playBtn)
	restartBtn.x = display.contentWidth*0.5
	restartBtn.y = (display.contentHeight*0.5)+250
	group:insert(restartBtn)



	return true	-- indica toque bem sucedida

end
  -- Chamado imediatamente após a cena mudou na tela:
function scene:enterScene( event )
    --print("Estou enterScene gameOver")
	local group = self.view
	storyboard.purgeScene("play")
	som_game_over = audio.loadSound( "game_over.mp3" )

	audio.play(som_game_over)
	-- Inserir o código aqui (por exemplo, contadores de início, áudio carga, ouvintes de início, etc)
end

  -- Chamado quando a cena está prestes a se mover fora da tela:
function scene:exitScene( event )
    --print("Estou existeScene gameOver")
	local group = self.view
	-- Chamado quando a cena está prestes a se mover fora da tela:
end

  -- Se a visão de cena é removido, a cena: destroyScene () será chamado pouco antes:
function scene:destroyScene( event )
    --print("Estou destroyScene gameOver")
	local group = self.view

end

-----------------------------------------------------------------------------------------
-- FIM DA SUA IMPLEMENTAÇÃO
-----------------------------------------------------------------------------------------

-- evento "createScene" é despachado se a visão de cena não existe
scene:addEventListener( "createScene", scene )

-- evento "enterScene" é despachado sempre que transição de cena terminou
scene:addEventListener( "enterScene", scene )

-- evento "exitScene" é despachado sempre que antes da transição da cena seguinte começa
scene:addEventListener( "exitScene", scene )

-- Evento "destroyScene" é despachado antes vista é descarregado, o que pode ser
-- Descarregadas automaticamente em situações de pouca memória, ou explicitamente, através de uma chamada para
-- Storyboard.purgeScene () ou storyboard.removeScene ().
scene:addEventListener( "destroyScene", scene )

return scene



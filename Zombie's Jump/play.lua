local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local fisica = require( "physics" )
fisica.start()
fisica.setGravity(0, 100)

require( "PlataformasThree" )
require("PlataformasTwo")

local widget = require( "widget" )

function display:tap (event)
	if (event.x < display.contentWidth/2) then
		transition.to( zumbi, {time=450, x = zumbi.x-155, y = zumbi.y-30} ) 
		--zumbi:applyLinearImpulse(  50, 1, zumbi.x-150, zumbi.y-230 )
		audio.play ( somPulo )
	else 
		transition.to( zumbi, {time=450, x = zumbi.x+155, y = zumbi.y -30} )
		audio.play ( somPulo )
	end
end

function onCollisionCerebro(event)
	if( event.object1.myName == "zumbi" and event.object2.myName == "cerebro" ) then
		if event.object2.valor == 1 then
			local removeCerebro = event.object2
			life.x = life.x + 90
			audio.play ( somComerCerebro )
			removeCerebro:removeSelf( )
		elseif event.object2.valor == 2 then
			local removeCerebro = event.object2
			life.x = life.x + 220
			score = score + 5
			audio.play ( somComerCerebro )
			removeCerebro:removeSelf( )
		end
	end
	if ( event.object1.myName == "cerebro" and event.object2.myName == "zumbi" ) then
		if event.object1.valor == 1 then
			local removeCerebro = event.object1
			life.x = life.x + 90
			removeCerebro:removeSelf()
		elseif event.object1.valor == 2 then
			local removeCerebro = event.object1
			life.x = life.x + 220
			score = score + 5
			removeCerebro:removeSelf()
		end
	end
end 

function mostraScore( )
	messageScore.text = "Scores ".. score
end

function onCollisionGameOver(event)
	if( event.object1.myName == "zumbi" and event.object2.myName == "chao" or
		event.object1.myName == "chao" and event.object2.myName == "zumbi" or
		event.object1.myName == "zumbi" and event.object2.myName == "paredeDireita" or
		event.object1.myName == "paredeDireita" and event.object2.myName == "zumbi" or
		event.object1.myName == "zumbi" and event.object2.myName == "paredeEsquerda" or
		event.object1.myName == "paredeEsquerda" and event.object2.myName == "zumbi" or
		life.x <= -(display.contentWidth)) then
		local gameOver = display.newImageRect( "gameover.png", 500, 150 )
		gameOver.x = display.contentWidth/2
		gameOver.y = display.contentHeight/2
		score = 0
		audio.pause(main_song)
		transition.pause()
		--timer.cancel(event.source)
	end
end

function andamentoLife()
	life.x = life.x -3 
	--transition.to( life, {time=100, x = life.x - 3} )
	if life.x < -(display.contentWidth*0.8) then
		life:setFillColor(255, 0, 0)
	end
	print( life.x )
end

function sorteiaCerebro()
	sorteioCerebro = math.random( 1, 10 )

	if (sorteioCerebro==1) then
		cerebro = display.newImageRect( "cerebro.png", 60, 60 )
		cerebro.myName = "cerebro"
		cerebro.valor = 1
		fisica.addBody(cerebro, {bounce = 0.0, friction=1, density=1})
		local sorteioPosicaoCerebro = math.random( 1, 5 )
		if (sorteioPosicaoCerebro==1) then
			cerebro.x = display.contentWidth/2-320
			cerebro.y = math.random( 0, display.contentHeight )
			cerebro.myName = "cerebro"
		elseif (sorteioPosicaoCerebro==2) then
			cerebro.x = display.contentWidth/2
			cerebro.y = math.random( 0, display.contentHeight )
			cerebro.myName = "cerebro"
		elseif (sorteioPosicaoCerebro==3) then
			cerebro.x = display.contentWidth/2+320
			cerebro.y = math.random( 0, display.contentHeight )
			cerebro.myName = "cerebro"
		elseif (sorteioPosicaoCerebro==4) then
			cerebro.x = display.contentWidth/2-160
			cerebro.y = math.random( 0, display.contentHeight )
			cerebro.myName = "cerebro"
		elseif (sorteioPosicaoCerebro==5) then
			cerebro.x = display.contentWidth/2+160
			cerebro.y = math.random( 0, display.contentHeight )
			cerebro.myName = "cerebro"
		end
	end
end

function onCollisionCerebroComCerebro(event)
	if( event.object1.myName == "cerebro" and event.object2.myName == "cerebro" ) then
		cerebroMaster = event.object1
		cerebroSlave = event.object2
		escalaX = cerebroMaster.xScale * 1.5
		escalaY = cerebroMaster.yScale * 1.5
		cerebroMaster.valor = 2

		if cerebroMaster.xScale < escalaX then
			cerebroMaster.xScale = cerebroSlave.xScale * 1.5
			cerebroMaster.yScale = cerebroSlave.yScale * 1.5
			cerebroMaster.valor = 2
			cerebroSlave:removeSelf( )
		else 
			cerebroSlave:removeSelf( )
		end
	end
end

cont = 0

function youReady(event)
	if event.name == "tap" then
		cont = cont + 1
		if cont == 1 then
			print ("YOU READY!! true")
			ready:removeSelf( )
			transition.resume()
		end
	end
end

function buttonHit(event)
	storyboard.gotoScene ( event.target.destination, {effect = "slideUp"} )	
	print( event.target.destination)
		return true
end


-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	local background = display.newImageRect( "background.jpg", (display.contentWidth - display.screenOriginX)-display.screenOriginX, (display.contentHeight - display.screenOriginY)-display.screenOriginY )
	background.x = display.contentWidth*0.5
	background.y = display.contentHeight*0.5
	group:insert( background )

	life = display.newRect( 1, display.contentHeight, display.contentWidth*2, 80 )
	life:setFillColor(0, 255, 255)
	life.MyName = "life"
	group:insert( life )

	zumbi = display.newImageRect( "zumbi.png", 80, 80 )
	zumbi.myName = "zumbi"
	--zumbi.alpha = 0.5
	zumbi.isFixedRotation = true
	group:insert( zumbi )

	chao = display.newRect(0, display.contentHeight, display.contentWidth*2, 1)
	paredeesquerda = display.newRect(0,0,1, display.contentHeight*2)
	parededireita = display.newRect(display.contentWidth, display.contentHeight,1, display.contentHeight*2)

	chao.myName = "chao"
	parededireita.myName = "paredeDireita"
	paredeesquerda.myName = "paredeEsquerda"

	group:insert( chao )
	group:insert( parededireita )
	group:insert( paredeesquerda )

	fisica.addBody(chao, "kinematic", {isSensor=true})
	fisica.addBody(paredeesquerda, "kinematic", {isSensor=true})
	fisica.addBody(parededireita, "kinematic", {isSensor=true})

	score = 0

	messageScore = display.newText( "Score: ".. score, 250, 50, native.systemFont, 50 )
	messageScore.x = (display.contentWidth+150)-display.contentWidth
	messageScore.y = (display.contentHeight+80)-display.contentHeight

	group:insert( messageScore )

	audio.play(main_song)

	ready = display.newImageRect( "ready.png", 500, 300 )
	ready.x = display.contentWidth*0.5
	ready.y = display.contentHeight*0.5
	--group:insert( ready )

	sorteio = math.random(1, 3)

	tuplaPar = {}
	tuplaImpar = {}
	pltPar = {}
	pltImpar = {}

	tuplaImpar[1] = PlataformasThree:new()
	pltImpar[1] = tuplaImpar[1]:sorteia(sorteio)
	tuplaImpar[1].myName = "plataformasImpares"
	tuplaImpar[1].collType = "passthru"

	if sorteio==1 then
		transition.to(tuplaImpar[1].plataforma1.plataformaValendo,{time=28000000,y = tuplaImpar[1].plataforma1.plataformaValendo.y + 2800000})
	elseif sorteio==2 then
		transition.to(tuplaImpar[1].plataforma2.plataformaValendo,{time=28000000,y = tuplaImpar[1].plataforma2.plataformaValendo.y + 2800000})
	elseif sorteio==3 then
		transition.to(tuplaImpar[1].plataforma3.plataformaValendo,{time=28000000,y = tuplaImpar[1].plataforma3.plataformaValendo.y + 2800000})
	end

	alt = 0

	tuplaPar[1] = PlataformasTwo:new()
	pltPar[1] = tuplaPar[1]:proximoDois(sorteio, alt)

	tuplaPar[1].myName = "PlataformasPares"
	tuplaPar[1].collType = "passthru"

	if pltPar[1]==1 then
		transition.to(tuplaPar[1].plataforma1.plataformaValendo,{time=28000000,y = tuplaPar[1].plataforma1.plataformaValendo.y + 2800000})
	elseif pltPar[1]==2 then
		transition.to(tuplaPar[1].plataforma2.plataformaValendo,{time=28000000,y = tuplaPar[1].plataforma2.plataformaValendo.y + 2800000})
	end

	for i=2, 100 do

		alt = alt + 200

		tuplaImpar[i] = PlataformasThree:new()
		pltImpar[i] = tuplaImpar[i]:sorteiaDois(pltPar[i-1], alt)
		
		if pltImpar[i]==1 then
			transition.to(tuplaImpar[i].plataforma1.plataformaValendo,{time=28000000,y = tuplaImpar[i].plataforma1.plataformaValendo.y + 2800000})
		elseif pltImpar[i]==2 then
			transition.to(tuplaImpar[i].plataforma2.plataformaValendo,{time=28000000,y = tuplaImpar[i].plataforma2.plataformaValendo.y + 2800000})
		elseif pltImpar[i]==3 then
			transition.to(tuplaImpar[i].plataforma3.plataformaValendo,{time=28000000,y = tuplaImpar[i].plataforma3.plataformaValendo.y + 2800000})
		end


		tuplaPar[i] = PlataformasTwo:new()
		pltPar[i] = tuplaPar[i]:proximoDois(pltImpar[i], alt)
		
		if pltPar[i]==1 then
			transition.to(tuplaPar[i].plataforma1.plataformaValendo,{time=28000000,y = tuplaPar[i].plataforma1.plataformaValendo.y + 2800000})
		elseif pltPar[i]==2 then
			transition.to(tuplaPar[i].plataforma2.plataformaValendo,{time=28000000,y = tuplaPar[i].plataforma2.plataformaValendo.y + 2800000})
		end

		if cont == 0 then
			transition.pause()
		end

		tuplaPar[i].myName = "plataformasPares"
		tuplaImpar[i].myName = "plataformasImpares"
		
		tuplaImpar[i].collType = "passthru"
		tuplaPar[i].collType = "passthru"
		
		print (tuplaPar[i].myName)
		print (tuplaImpar[i].myName)

	end

	--posicionar o zumbi no inicio do jogo
	if(sorteio == 1) then
		zumbi.x = display.contentWidth/2-320
		zumbi.y = display.contentHeight-80
		
	elseif(sorteio == 2) then
		zumbi.x = display.contentWidth/2
		zumbi.y = display.contentHeight-80
		
	elseif(sorteio == 3) then
		zumbi.x = display.contentWidth/2+320
		zumbi.y = display.contentHeight-80
		
	end

	fisica.addBody(zumbi, "dynamic", {bounce = 0.1, friction=1, density=1})


	-- CREATE display objects and add them to 'group' here.
	-- Example use-case: Restore 'group' from previously saved state.

	function chao:collision( event )
		if ( event.phase == "began" ) then
			event.other:removeSelf()
			print ("cheguei na remocao dos objetos no chao")
		end
		
	end

	function zumbi:collision( event )
		--print ("Colisao", plataformas.collType)
		--plataformas.collType = "fixe"
		if ( event.phase == "began" ) then
			event.contact.isEnabled = true
			self.isSensor = false 
			self.isAwake = true
			self.linearDamping = 1
			--self.setAsSensor = false
			--print ("alguma coisa")
			if event.other.myName ~= "cerebro" and event.other.myName ~= "life"  then
				score = score + 1
			end
			
		end
		
	end

	function zumbi:preCollision ( event )
		--print( "Pre colisao", event.other.collType )
		--plataformas.collType = "passthru"
	    --if plataformas.myName == "plataformasPares" or plataformas.myName == "plataformasImpares" then
	    print ("cheguei antes")
	    event.other.bodyType = "kinematic"
		if event.other.collType == "passthru" then
	        event.contact.isEnabled = false
			self.isSensor = true 
			self.isAwake = true
			self.isFixedRotation = true
			self.linearDamping = 1
			--self.setAsSensor = true
			event.other.bodyType = "kinematic"
			print ("cheguei aqui")
			--plataformas.contact.isEnabled = false
			--plataformas.bodyType = "kinematic"
			--plataformas.isSensor = true
			
	        
	    end
	end

end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view

	somPulo = audio.loadSound("boing_wav.wav")
	somComerCerebro = audio.loadSound("squish_wav.wav")
	

	Runtime:addEventListener( "tap", display )
	Runtime:addEventListener("collision", onCollisionCerebro)
	Runtime:addEventListener("collision", onCollisionCerebroComCerebro)
	Runtime:addEventListener("collision", onCollisionGameOver)
	Runtime:addEventListener("enterFrame", mostraScore)
	zumbi:addEventListener( "preCollision" )
	zumbi:addEventListener( "collision" )
	chao:addEventListener( "collision" )
	Runtime:addEventListener( "tap", youReady )
	timer.performWithDelay(500, sorteiaCerebro,0)
	timer.performWithDelay(100, andamentoLife,0)
	-- INSERT code here (e.g. start timers, load audio, start listeners, etc.)

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view

	-- INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	-- Remove listeners attached to the Runtime, timers, transitions, audio tracks

	audio.pause(main_song)
	Runtime:removeEventListener( "tap", display )
	Runtime:removeEventListener( "collision", onCollisionCerebro )
	Runtime:removeEventListener( "collision", onCollisionCerebroComCerebro )
	Runtime:removeEventListener( "collision", onCollisionGameOver )
	Runtime:removeEventListener( "enterFrame", mostraScore )
	zumbi:removeEventListener( "preCollision" )
	zumbi:removeEventListener( "collision" )
	chao:removeEventListener( "collision" )

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
	




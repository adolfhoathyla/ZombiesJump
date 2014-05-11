local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local fisica = require( "physics" )
fisica.start()
fisica.setGravity(0, 9.8)

require "sqlite3"

local path = system.pathForFile("pontuacaozj.sqlite", system.DocumentsDirectory)
db = sqlite3.open( path )

local tablesetup = "CREATE TABLE IF NOT EXISTS pontuacao (pont INTEGER);"
db:exec( tablesetup )

--fisica.setDrawMode("hybrid")

require( "PlataformasThree" )
require("PlataformasTwo")

local widget = require( "widget" )

podePular = 1

function display:tap (event)
	if event.numTaps == 1 and podePular == 1 then
		print ("NUM TAPS: ", event.numTaps)
		podePular = 0
		if (event.x < display.contentWidth/2) then
			transition.to( zumbi, {time=350, x = zumbi.x-155, y = zumbi.y-10} ) 
			--zumbi:applyLinearImpulse(  50, 1, zumbi.x-150, zumbi.y-230 )
			audio.play ( somPulo )
		else 
			transition.to( zumbi, {time=350, x = zumbi.x+155, y = zumbi.y -10} )
			audio.play ( somPulo )
		end
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
	messageScore.text = score
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

function andamentoLife()
	life.x = life.x -3 
	--transition.to( life, {time=100, x = life.x - 3} )
	if life.x < -(display.contentWidth*0.8) then
		life:setFillColor(255, 0, 0)
	else
		life:setFillColor(0, 255, 255)
	end
	print( life.x )
end

function buttonHit(event)
	storyboard.gotoScene ( event.target.destination, {effect = "flip"} )	
	print( event.target.destination)
	return true
end


-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	audio.pause(menu_song)

		--FONTE 
	if "Windows" == system.getInfo( "platformName" ) then 
		fonte = "Nosifer Regular" 
	elseif "Android" == system.getInfo( "platformName" ) then 
		fonte = "Nosifer-Regular" 
	end
	print("Estou no create scene!")

	main_song = audio.loadStream( "main_music_zj.mp3" )

	--local background = display.newImageRect( "background.jpg", (display.contentWidth - display.screenOriginX)-display.screenOriginX, (display.contentHeight - display.screenOriginY)-display.screenOriginY )
	--background.x = display.contentWidth*0.5
	--background.y = display.contentHeight*0.5
	--group:insert( background )

	lua = display.newImageRect( "lua.png", 400, 400 )
	lua.x = display.contentWidth-100
	lua.y = -300
	transition.to( lua, {time=1505000, y=lua.y+20000} )
	group:insert(lua)


	terra = display.newImageRect( "terra.png", 150, 150 )
	terra.x = display.contentWidth-600
	terra.y = -400
	transition.to( terra, {time=2005000, y=terra.y+20000} )
	group:insert(terra)

	marte = display.newImageRect( "marte.png", 80, 80 )
	marte.x = display.contentWidth-750
	marte.y = -300
	transition.to( marte, {time=550500, y=marte.y+20000} )
	group:insert(marte)

	venus = display.newImageRect( "venus.png", 120, 120 )
	venus.x = display.contentWidth*0.5+100
	venus.y = -450
	transition.to( venus, {time=406000, y=venus.y+20000} )
	group:insert(venus)

	saturno = display.newImageRect( "saturno.png", 80, 80 )
	saturno.x = display.contentWidth-800
	saturno.y = -200
	transition.to( saturno, {time=3005000, y=saturno.y+20000} )
	group:insert(saturno)

	life = display.newRect( 1, display.contentHeight, display.contentWidth*2, 80 )
	life:setFillColor(0, 255, 255)
	life.MyName = "life"
	--transition.to( life, {time=20000, x=life.x-200} )
	group:insert( life )

	zumbi = display.newImageRect( arquivo_personagem, 80, 80 )
	zumbi.myName = "zumbi"
	zumbi.alpha = 0.7
	zumbi.isFixedRotation = true
	--podePular = 0
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
	cont = 0

	messageScore = display.newText( score, 250, 50, fonte, 35 )
	messageScore.x = 70
	messageScore.y = (display.contentHeight+50)-display.contentHeight

	group:insert( messageScore )


	ready = display.newText( "Get ready!", 500, 300, fonte, 50 )
	ready.x = display.contentWidth*0.5
	ready.y = display.contentHeight*0.5

	group:insert( ready )

	sorteio = math.random(1, 3)

	tuplaPar = {}
	tuplaImpar = {}
	pltPar = {}
	pltImpar = {}

	tuplaImpar[1] = PlataformasThree:new()
	pltImpar[1] = tuplaImpar[1]:sorteia(sorteio)

	if sorteio==1 then
		transition.to(tuplaImpar[1].plataforma1.plataformaValendo,{time=27000000,y = tuplaImpar[1].plataforma1.plataformaValendo.y + 3000000})
		tuplaImpar[1].plataforma1.plataformaValendo.myName = "plataformasImpares"
		tuplaImpar[1].plataforma1.plataformaValendo.collType = "fixe"
		group:insert(tuplaImpar[1].plataforma1.plataformaValendo)
	elseif sorteio==2 then
		transition.to(tuplaImpar[1].plataforma2.plataformaValendo,{time=27000000,y = tuplaImpar[1].plataforma2.plataformaValendo.y + 3000000})
		tuplaImpar[1].plataforma2.plataformaValendo.myName = "plataformasImpares"
		tuplaImpar[1].plataforma2.plataformaValendo.collType = "fixe"
		group:insert(tuplaImpar[1].plataforma2.plataformaValendo)
	elseif sorteio==3 then
		transition.to(tuplaImpar[1].plataforma3.plataformaValendo,{time=27000000,y = tuplaImpar[1].plataforma3.plataformaValendo.y + 3000000})
		tuplaImpar[1].plataforma3.plataformaValendo.myName = "plataformasImpares"
		tuplaImpar[1].plataforma3.plataformaValendo.collType = "fixe"
		group:insert(tuplaImpar[1].plataforma3.plataformaValendo)
	end

	alt = 0

	tuplaPar[1] = PlataformasTwo:new()
	pltPar[1] = tuplaPar[1]:proximoDois(sorteio, alt)

	if pltPar[1]==1 then
		transition.to(tuplaPar[1].plataforma1.plataformaValendo,{time=27000000,y = tuplaPar[1].plataforma1.plataformaValendo.y + 3000000})
		tuplaPar[1].plataforma1.plataformaValendo.myName = "plataformasPares"
		tuplaPar[1].plataforma1.plataformaValendo.collType = "passthru"
		group:insert(tuplaPar[1].plataforma1.plataformaValendo)
	elseif pltPar[1]==2 then
		transition.to(tuplaPar[1].plataforma2.plataformaValendo,{time=27000000,y = tuplaPar[1].plataforma2.plataformaValendo.y + 3000000})
		tuplaPar[1].plataforma2.plataformaValendo.myName = "plataformasPares"
		tuplaPar[1].plataforma2.plataformaValendo.collType = "passthru"
		group:insert(tuplaPar[1].plataforma2.plataformaValendo)
	end

	for i=2, 100 do

		alt = alt + 200

		tuplaImpar[i] = PlataformasThree:new()
		pltImpar[i] = tuplaImpar[i]:sorteiaDois(pltPar[i-1], alt)
		
		if pltImpar[i]==1 then
			transition.to(tuplaImpar[i].plataforma1.plataformaValendo,{time=27000000,y = tuplaImpar[i].plataforma1.plataformaValendo.y + 3000000})
			tuplaImpar[i].plataforma1.plataformaValendo.myName = "plataformasImpares"
			tuplaImpar[i].plataforma1.plataformaValendo.collType = "passthru"
			group:insert(tuplaImpar[i].plataforma1.plataformaValendo)
		elseif pltImpar[i]==2 then
			transition.to(tuplaImpar[i].plataforma2.plataformaValendo,{time=27000000,y = tuplaImpar[i].plataforma2.plataformaValendo.y + 3000000})
			tuplaImpar[i].plataforma2.plataformaValendo.myName = "plataformasImpares"
			tuplaImpar[i].plataforma2.plataformaValendo.collType = "passthru"
			group:insert(tuplaImpar[i].plataforma2.plataformaValendo)
		elseif pltImpar[i]==3 then
			transition.to(tuplaImpar[i].plataforma3.plataformaValendo,{time=27000000,y = tuplaImpar[i].plataforma3.plataformaValendo.y + 3000000})
			tuplaImpar[i].plataforma3.plataformaValendo.myName = "plataformasImpares"
			tuplaImpar[i].plataforma3.plataformaValendo.collType = "passthru"
			group:insert(tuplaImpar[i].plataforma3.plataformaValendo)
		end


		tuplaPar[i] = PlataformasTwo:new()
		pltPar[i] = tuplaPar[i]:proximoDois(pltImpar[i], alt)
		
		if pltPar[i]==1 then
			transition.to(tuplaPar[i].plataforma1.plataformaValendo,{time=27000000,y = tuplaPar[i].plataforma1.plataformaValendo.y + 3000000})
			tuplaPar[i].plataforma1.plataformaValendo.myName = "plataformasPares"
			tuplaPar[i].plataforma1.plataformaValendo.collType = "passthru"
			group:insert(tuplaPar[i].plataforma1.plataformaValendo)
		elseif pltPar[i]==2 then
			transition.to(tuplaPar[i].plataforma2.plataformaValendo,{time=27000000,y = tuplaPar[i].plataforma2.plataformaValendo.y + 3000000})
			tuplaPar[i].plataforma2.plataformaValendo.myName = "plataformasPares"
			tuplaPar[i].plataforma2.plataformaValendo.collType = "passthru"
			group:insert(tuplaPar[i].plataforma2.plataformaValendo)
		end

		if cont == 0 then
			transition.pause()
		end

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

	fisica.addBody(zumbi, "dynamic", {bounce = 0.0, friction=1, density=1})


	-- CREATE display objects and add them to 'group' here.
	-- Example use-case: Restore 'group' from previously saved state.

end




-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view

	audio.play(main_song)

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

	function ChuvaDeEstrelas()
			alturaChuva = math.random( 0, display.contentHeight )

			estrela = display.newCircle( 10, 10, 1 )
			estrela.myName = "estrela"
			estrela.x = math.random(0, display.contentWidth)
			estrela.y = alturaChuva
			group:insert(estrela)
			transition.to( estrela, {time= 50000, y = estrela.y+5000} )

			--estrelaTwo = display.newCircle( 10, 10, 2 )
			--estrelaTwo.myName = "estrela"
			--estrela:setFillColor( 100, 100, 100 )
			--estrelaTwo.x = math.random(0, display.contentWidth)
			--estrelaTwo.y = -(alturaChuva)
			--transition.to( estrelaTwo, {time= 25000, y = estrelaTwo.y+5000} )

	end

	function sorteiaCerebro()
		sorteioCerebro = math.random( 1, 13 )

		if (sorteioCerebro==1) then
			cerebro = display.newImageRect( "cerebro.png", 60, 60 )
			cerebro.myName = "cerebro"
			cerebro.valor = 1
			group:insert(cerebro)
			fisica.addBody(cerebro, {bounce = 0.0, friction=1, density=1})
			local altura = 0;
			local sorteioPosicaoCerebro = math.random( 1, 5 )
			if (sorteioPosicaoCerebro==1) then
				cerebro.x = display.contentWidth/2-320
				altura = math.random( display.contentHeight*2, display.contentHeight*5 )
				cerebro.y = -(altura)
				cerebro.myName = "cerebro"
			elseif (sorteioPosicaoCerebro==2) then
				cerebro.x = display.contentWidth/2
				altura = math.random( display.contentHeight*2, display.contentHeight*5 )
				cerebro.y = -(altura)
				cerebro.myName = "cerebro"
			elseif (sorteioPosicaoCerebro==3) then
				cerebro.x = display.contentWidth/2+320
				altura = math.random( display.contentHeight*2, display.contentHeight*5 )
				cerebro.y = -(altura)
				cerebro.myName = "cerebro"
			elseif (sorteioPosicaoCerebro==4) then
				cerebro.x = display.contentWidth/2-160
				altura = math.random( display.contentHeight*2, display.contentHeight*5 )
				cerebro.y = -(altura)
				cerebro.myName = "cerebro"
			elseif (sorteioPosicaoCerebro==5) then
				cerebro.x = display.contentWidth/2+160
				altura = math.random( display.contentHeight*2, display.contentHeight*5 )
				cerebro.y = -(altura)
				cerebro.myName = "cerebro"
			end
		end
	end

	function onCollisionGameOver(event)
		if( event.object1.myName == "zumbi" and event.object2.myName == "chao" or
			event.object1.myName == "chao" and event.object2.myName == "zumbi" or
			event.object1.myName == "zumbi" and event.object2.myName == "paredeDireita" or
			event.object1.myName == "paredeDireita" and event.object2.myName == "zumbi" or
			event.object1.myName == "zumbi" and event.object2.myName == "paredeEsquerda" or
			event.object1.myName == "paredeEsquerda" and event.object2.myName == "zumbi" or
			life.x <= -(display.contentWidth)) then
				storyboard.gotoScene ( "gameOver", {effect = "flip"} )	
			--timer.cancel(event.source)
		end
	end

	function zumbi:preCollision ( event )
		print( "Pre colisao", event.other.collType )
		--plataformas.collType = "passthru"
	    --if plataformas.myName == "plataformasPares" or plataformas.myName == "plataformasImpares" then
	    event.other.bodyType = "kinematic"
	    print ("TO CHEGANDO AQUI")
		if event.other.collType == "passthru" then
			print ("TOOOO AQUIIIIIIII")
	        event.contact.isEnabled = false
			self.isSensor = true 
			self.isAwake = true
			self.isFixedRotation = true
			self.linearDamping = 1
			--self.setAsSensor = true
			event.other.bodyType = "kinematic"
			--plataformas.contact.isEnabled = false
			--plataformas.bodyType = "kinematic"
			--plataformas.isSensor = true
			
	        
	    end
	end
	
	function ficaDePeInocente( event )
		if zumbi.rotation ~= 0 then
			print ("ROTATION: ", zumbi.rotation)
			zumbi.rotation = 0
		end
	end

	verificadorScore = 0

	function zumbi:collision( event )
		--print ("Colisao", plataformas.collType)
		--plataformas.collType = "fixe"
		if ( event.phase == "began" ) then
			
			--self.setAsSensor = false
			--print ("alguma coisa")
			
			print ("Colision ", event.other.collType)
			
			if event.other.myName == "plataformasPares" or event.other.myName == "plataformasImpares" then
				event.other.collType = "fixe"
				event.contact.isEnabled = true
				self.isSensor = false 
				self.isAwake = true
				self.linearDamping = 1
				zumbi:applyLinearImpulse( 0, 1000, zumbi.x, zumbi.y+2000 )
				if event.other.myName == "plataformasPares" and verificadorScore==0 then
					score = score + 1
					verificadorScore=1
				
					print ("OBJETO COLIDINDO COM O WALTER", event.other.myName)

				elseif event.other.myName == "plataformasPares" and verificadorScore==1 then
					verificadorScore=0
			
				end

				if event.other.myName == "plataformasImpares" and verificadorScore==0 then
					score = score + 1
					verificadorScore=1
				elseif event.other.myName == "plataformasImpares" and verificadorScore==1 then
					verificadorScore=0
				end
			end
			
		end
		if event.phase == "ended" then
			podePular = 1
			print ("CHEGUEI NO ENDED!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
		end
		
	end

	function chao:collision( event )
		if ( event.phase == "began" ) then
			if event.other.myName ~= "zumbi" then
				event.other:removeSelf()
				print ("cheguei na remocao dos objetos no chao")
			end
		end
		
	end

	somPulo = audio.loadSound("boing_wav.wav")
	somComerCerebro = audio.loadSound("squish_wav.wav")
	

	print ("Estou no enter scene")
	

	Runtime:addEventListener( "tap", display )
	Runtime:addEventListener("collision", onCollisionCerebro)
	Runtime:addEventListener("collision", onCollisionCerebroComCerebro)
	Runtime:addEventListener("collision", onCollisionGameOver)
	Runtime:addEventListener("enterFrame", mostraScore)
	Runtime:addEventListener("enterFrame", ficaDePeInocente)
	Runtime:addEventListener("enterFrame", ChuvaDeEstrelas)
	zumbi:addEventListener( "preCollision" )
	zumbi:addEventListener( "collision" )
	
	chao:addEventListener( "collision" )
	Runtime:addEventListener( "tap", youReady )
	timerCerebros = timer.performWithDelay(500, sorteiaCerebro,0)
	timerLife = timer.performWithDelay(100, andamentoLife,0)

	-- INSERT code here (e.g. start timers, load audio, start listeners, etc.)

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view

	-- INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	-- Remove listeners attached to the Runtime, timers, transitions, audio tracks

	print("Estou no exit scene")

	
	Runtime:removeEventListener( "tap", display )
	Runtime:removeEventListener( "collision", onCollisionCerebro )
	Runtime:removeEventListener( "collision", onCollisionCerebroComCerebro )
	Runtime:removeEventListener( "collision", onCollisionGameOver )
	Runtime:removeEventListener( "enterFrame", mostraScore )
	Runtime:removeEventListener("enterFrame", ChuvaDeEstrelas)
	zumbi:removeEventListener( "preCollision" )
	zumbi:removeEventListener( "collision" )
	chao:removeEventListener( "collision" )
	
	timer.cancel( timerCerebros )
	timer.cancel( timerLife )
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view

	--audio.pause(main_song)
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
	




local fisica = require( "physics" )
fisica.start()
fisica.setGravity(0, 9.8)

require( "PlataformasThree" )
require("PlataformasTwo")

local background = display.newImageRect( "background.jpg", (display.contentWidth - display.screenOriginX)-display.screenOriginX, (display.contentHeight - display.screenOriginY)-display.screenOriginY )
background.x = display.contentWidth*0.5
background.y = display.contentHeight*0.5

local zumbi = display.newImageRect( "zumbi.png", 80, 80 )
zumbi.myName = "zumbi"

local chao = display.newRect(0, display.contentHeight, display.contentWidth*2, 20)
local paredeesquerda = display.newRect(0,0,20, display.contentHeight*2)
local parededireita = display.newRect(display.contentWidth, display.contentHeight,20, display.contentHeight*2)

chao.myName = "chao"
parededireita.myName = "paredeDireita"
paredeesquerda.myName = "paredeEsquerda"

fisica.addBody(chao, "kinematic", {isSensor=true})
fisica.addBody(paredeesquerda, "kinematic", {isSensor=true})
fisica.addBody(parededireita, "kinematic", {isSensor=true})

score = 0

tempo = 0

messageTempo = display.newText( "Tempo: ".. tempo, 250, 50, native.systemFont, 50 )
messageTempo.x = (display.contentWidth+150)-display.contentWidth
messageTempo.y = (display.contentHeight+100)-display.contentHeight

messageScore = display.newText( "Score: ".. score, 250, 50, native.systemFont, 50 )
messageScore.x = (display.contentWidth+150)-display.contentWidth
messageScore.y = (display.contentHeight+150)-display.contentHeight

--inicio, lógica das plataformas
sorteio = math.random(1, 3)

tuplaPar = {}
tuplaImpar = {}
pltPar = {}
pltImpar = {}

tuplaImpar[1] = PlataformasThree:new()
pltImpar[1] = tuplaImpar[1]:sorteia(sorteio)
tuplaImpar[1].myName = "plataformasImpares"

alt = 0

tuplaPar[1] = PlataformasTwo:new()
pltPar[1] = tuplaPar[1]:proximoDois(sorteio, alt)

tuplaPar[1].myName = "PlataformasPares"
for i=2, 10 do

	alt = alt + 200

	tuplaImpar[i] = PlataformasThree:new()
	pltImpar[i] = tuplaImpar[i]:sorteiaDois(pltPar[i-1], alt)

	tuplaPar[i] = PlataformasTwo:new()
	pltPar[i] = tuplaPar[i]:proximoDois(pltImpar[i], alt)

	tuplaPar[i].myName = "plataformasPares"
	tuplaImpar[i].myName = "plataformasImpares"


	--esta porcaria não funciona!!!!!!!!!!!!
	zumbi:addEventListener( "preCollision", function ( event )
	    local plataformas = event.other
	    if plataformas.myName == "plataformasPares" or plataformas.myName == "plataformasImpares" then
	        event.contact.isEnabled = false
	        print( "estou aqui" )
	    end
	end )

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

function display:tap (event)
	if (event.x < display.contentWidth/2) then
		transition.to( zumbi, {time=1000, x = zumbi.x-100, y = zumbi.y-80} ) --x = zumbi.x-155, y = zumbi.y-230
		--zumbi:applyLinearImpulse(  50, 1, zumbi.x-150, zumbi.y-230 )

		--cerebro.isVisible = false

		--transition.to( cerebro, {time=3000, alpha=0} )
		score = score + 1
	else 
		transition.to( zumbi, {time=1000, x = zumbi.x+155, y = zumbi.y -230} )
		score = score + 1
	end
end

qtdCerebros = 0

local function onCollisionCerebro(event)
	if( event.object1.myName == "zumbi" and event.object2.myName == "cerebro" ) then
		local removeCerebro = event.object2
		qtdCerebros = qtdCerebros + 1
		print ("cerebros: " .. qtdCerebros)
		removeCerebro:removeSelf( )
	elseif ( event.object1.myName == "cerebro" and event.object2.myName == "zumbi" ) then
		local removeCerebro = event.object1
		qtdCerebros = qtdCerebros + 1
		print ("cerebros: " .. qtdCerebros)
		removeCerebro:removeSelf()
	end
end

local function onCollisionCerebroComCerebro(event)
	if( event.object1.myName == "cerebro" and event.object2.myName == "cerebro" ) then
		cerebroMaster = event.object1
		cerebroSlave = event.object2
		escalaX = cerebroMaster.xScale * 1.5
		escalaY = cerebroMaster.yScale * 1.5
		if cerebroMaster.xScale < escalaX then
			cerebroMaster.xScale = cerebroSlave.xScale * 1.5
			cerebroMaster.yScale = cerebroSlave.yScale * 1.5
			cerebroSlave:removeSelf( )
		else 
			cerebroSlave:removeSelf( )
		end
	end
end

local function sorteiaCerebro()
	sorteioCerebro = math.random( 1, 10 )

	if (sorteioCerebro==1) then
		cerebro = display.newImageRect( "cerebro.png", 60, 60 )
		cerebro.myName = "cerebro"
		fisica.addBody(cerebro, {bounce = 0.1, friction=1, density=1})
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

function mostraTempo( event )
	tempo = (event.time/1000)
	messageTempo.text = "Time ".. tempo
end

function mostraScore( )
	messageScore.text = "Scores ".. score
end

--terminar essa função - game over
local function onCollisionGameOver(event)
	if( event.object1.myName == "zumbi" and event.object2.myName == "chao" or
		event.object1.myName == "chao" and event.object2.myName == "zumbi" or
		event.object1.myName == "zumbi" and event.object2.myName == "paredeDireita" or
		event.object1.myName == "paredeDireita" and event.object2.myName == "zumbi" or
		event.object1.myName == "zumbi" and event.object2.myName == "paredeEsquerda" or
		event.object1.myName == "paredeEsquerda" and event.object2.myName == "zumbi") then
		local gameOver = display.newImageRect( "gameover.png", 500, 150 )
		gameOver.x = display.contentWidth/2
		gameOver.y = display.contentHeight/2
		score = 0
		tempo = 0
	end
end

--local function onCollisionScore(event)
--	if( ( event.object1.myName == "zumbi" and event.object2.myName == "plataformas_par" ) or 
--		( event.object1.myName == "plataformas_par" and event.object2.myName == "zumbi" ) or
--		( event.object1.myName == "zumbi" and event.object2.myName == "plataformas_impar" ) or 
--		( event.object1.myName == "plataformas_impar" and event.object2.myName == "zumbi" )) then
--		score = score + 1
--		print ("score: " .. score)
--	end
--end

--mostraScore()

Runtime:addEventListener( "tap", display )
Runtime:addEventListener("collision", onCollisionCerebro)
Runtime:addEventListener("collision", onCollisionCerebroComCerebro)
Runtime:addEventListener("collision", onCollisionGameOver)
--Runtime:addEventListener("collision", onCollisionScore)
timer.performWithDelay(500, sorteiaCerebro,0)
Runtime:addEventListener("enterFrame", mostraTempo)
Runtime:addEventListener("enterFrame", mostraScore)



--for i=1, 10 do
--	print("impar" .. pltImpar[i] )
--	print("par" .. pltPar[i] )
--end


local fisica = require( "physics" )
fisica.start()
fisica.setGravity(0, 9.8)

Plataforma = {}

function Plataforma:new( )
	local plataforma = {}

	plataforma.isVisible = false
	plataforma.plataformaValendo = 0

	function plataforma:criar()
		if (plataforma.isVisible) then
			self.plataformaValendo = display.newImageRect( "plataforma.png", 150, 30 )
			--self.plataformaValendo.collType = "fixe"
			fisica.addBody(self.plataformaValendo, "static", {bounce = 0.0, friction=1, density=1})
		end
	end

	function plataforma:posicionarEsquerda()
		self.plataformaValendo.x = display.contentWidth/2-320
		self.plataformaValendo.y = display.contentHeight-80
	end

	function plataforma:posicionarDireita()
		self.plataformaValendo.x = display.contentWidth/2+320
		self.plataformaValendo.y = display.contentHeight-80
	end

	function plataforma:posicionarCentro()
		self.plataformaValendo.x = display.contentWidth/2
		self.plataformaValendo.y = display.contentHeight-80
	end


	function plataforma:posicionarEsquerdaDois(altura)
		self.plataformaValendo.x = display.contentWidth/2-320
		self.plataformaValendo.y = (display.contentHeight-80)-altura
	end

	function plataforma:posicionarDireitaDois(altura)
		self.plataformaValendo.x = display.contentWidth/2+320
		self.plataformaValendo.y = (display.contentHeight-80)-altura
	end

	function plataforma:posicionarCentroDois(altura)
		self.plataformaValendo.x = display.contentWidth/2
		self.plataformaValendo.y = (display.contentHeight-80)-altura
	end

	function plataforma:movimentar()
		--self.plataformaValendo.y = self.plataformaValendo.y + 10
		--timer.performWithDelay(100, movimentar,0)
		--transition.to(self.plataformaValendo,{time = 3000,y = display.contentHeight + 100})
	end

	return plataforma
end

return Plataforma
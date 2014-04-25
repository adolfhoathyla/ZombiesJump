local fisica = require( "physics" )
fisica.start()
fisica.setGravity(0, 9.8)

PlataformaDois = {}

function PlataformaDois:new( )
	local plataforma_dois = {}

	plataforma_dois.isVisible = false
	plataforma_dois.plataformaValendo = 0

	function plataforma_dois:criar()
		if (plataforma_dois.isVisible) then
			self.plataformaValendo = display.newImageRect( "plataforma.png", 150, 30 )
			--self.plataformaValendo.collType = "fixe"
			fisica.addBody(self.plataformaValendo, "static", {bounce = 0.0, friction=1, density=1})
		end
	end

	function plataforma_dois:posicionarEsquerda()
		self.plataformaValendo.x = display.contentWidth/2-160
		self.plataformaValendo.y = display.contentHeight-180
	end

	function plataforma_dois:posicionarDireita()
		self.plataformaValendo.x = display.contentWidth/2+160
		self.plataformaValendo.y = display.contentHeight-180
	end

	function plataforma_dois:posicionarEsquerdaDois(altura)
		self.plataformaValendo.x = display.contentWidth/2-160
		self.plataformaValendo.y = (display.contentHeight-180)-altura
	end

	function plataforma_dois:posicionarDireitaDois(altura)
		self.plataformaValendo.x = display.contentWidth/2+160
		self.plataformaValendo.y = (display.contentHeight-180)-altura
	end

	return plataforma_dois
end

return PlataformaDois
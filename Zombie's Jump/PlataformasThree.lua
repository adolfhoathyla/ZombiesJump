require( "Plataforma" )

PlataformasThree = {}

function PlataformasThree:new()
	local plataformas_three = {}

	plataformas_three.plataforma1 = Plataforma:new()
	plataformas_three.plataforma2 = Plataforma:new()
	plataformas_three.plataforma3 = Plataforma:new()

	

	function plataformas_three:sorteia(escolhido)
		
		if(escolhido==1) then
			self.plataforma1.isVisible = true
			self.plataforma1:criar()
			self.plataforma1:posicionarEsquerda()

		elseif(escolhido==2) then
			self.plataforma2.isVisible = true
			self.plataforma2:criar()
			self.plataforma2:posicionarCentro()
	
		elseif(escolhido==3) then
			self.plataforma3.isVisible = true
			self.plataforma3:criar()
			self.plataforma3:posicionarDireita()

		end
		return escolhido
	end

--	function plataformas_three:tempinhoPlat(escolhido)
--		if escolhido==1 then
--			self.plataforma1:movimentar()
--		elseif escolhido==2 then
--			self.plataforma2:movimentar()
--		elseif escolhido==3 then
--			self.plataforma3:movimentar()
--		end
--	end

	function plataformas_three:sorteiaDois(escolhido, altura)
		
		if(escolhido==1) then
			outroSorteio = math.random(1, 2)
			if(outroSorteio==1) then
				self.plataforma1.isVisible = true
				self.plataforma1:criar()
				self.plataforma1:posicionarEsquerdaDois(altura)
			elseif(outroSorteio==2) then
				self.plataforma2.isVisible = true
				self.plataforma2:criar()
				self.plataforma2:posicionarCentroDois(altura)
			end

			return outroSorteio
		end
		if(escolhido==2) then
			maisoutroSorteio = math.random(2, 3)
			if(maisoutroSorteio==2) then
				self.plataforma2.isVisible = true
				self.plataforma2:criar()
				self.plataforma2:posicionarCentroDois(altura)
			elseif(maisoutroSorteio==3) then
				self.plataforma3.isVisible = true
				self.plataforma3:criar()
				self.plataforma3:posicionarDireitaDois(altura)
			end
			return maisoutroSorteio
		end
	end
	
	return plataformas_three
end

return PlataformasThree
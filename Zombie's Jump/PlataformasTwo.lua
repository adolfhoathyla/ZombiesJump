require( "PlataformaDois" )
require( "PlataformasThree" )

PlataformasTwo = {}

function PlataformasTwo:new()
	local plataformas_two = {}

	plataformas_two.plataforma1 = PlataformaDois:new()
	plataformas_two.plataforma2 = PlataformaDois:new()

	function plataformas_two:proximo(escolhido)
		if(escolhido==1) then
			self.plataforma1.isVisible = true
			self.plataforma1:criar()
			self.plataforma1:posicionarEsquerda()
			return escolhido
		end
		if(escolhido==2) then
			sorteio2 = math.random(1, 2)
			if(sorteio2==1) then
				self.plataforma1.isVisible = true
				self.plataforma1:criar()
				self.plataforma1:posicionarEsquerda()
			elseif(sorteio2==2) then
				self.plataforma2.isVisible = true
				self.plataforma2:criar()
				self.plataforma2:posicionarDireita()
			end
			return sorteio2
		end
		if(escolhido==3) then
			self.plataforma2.isVisible = true
			self.plataforma2:criar()
			self.plataforma2:posicionarDireita()
			return 2
		end
	end

--	function plataformas_two:tempinhoPlat(escolhido)
--		if escolhido==1 then
--			self.plataforma1:movimentar()
--		elseif escolhido==2 then
--			self.plataforma2:movimentar()
--		end
--	end

	--passar altura como parametro
	function plataformas_two:proximoDois(escolhido, altura)
		if(escolhido==1) then
			self.plataforma1.isVisible = true
			self.plataforma1:criar()
			self.plataforma1:posicionarEsquerdaDois(altura)
			return escolhido
		end
		if(escolhido==2) then
			sorteio2 = math.random(1, 2)
			if(sorteio2==1) then
				self.plataforma1.isVisible = true
				self.plataforma1:criar()
				self.plataforma1:posicionarEsquerdaDois(altura)
			elseif(sorteio2==2) then
				self.plataforma2.isVisible = true
				self.plataforma2:criar()
				self.plataforma2:posicionarDireitaDois(altura)
			end
			return sorteio2
		end
		if(escolhido==3) then
			self.plataforma2.isVisible = true
			self.plataforma2:criar()
			self.plataforma2:posicionarDireitaDois(altura)
			return 2
		end
	end
	
	return plataformas_two
end

return PlataformasTwo
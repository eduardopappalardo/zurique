<!-- #include virtual="/lib/lib.asp" -->
<%

	const LARGURA_FOTO = 640
	const ALTURA_FOTO = 480
	const LARGURA_PREVIA_FOTO = 80
	const ALTURA_PREVIA_FOTO = 60
	
	class Foto

		public codigoFoto
		public nomeArquivo
		public nomeArquivoPrevia
		public publicada
		public posicaoExibicao
		
	end class
	
	public sub salvarFoto()
	
		dim aspUpload, aspJpeg, pastaTemporaria, pastaFotos, arquivo, foto
		
		set aspUpload = Server.createObject("Persits.Upload")
		pastaTemporaria = Server.mapPath("temp")
		pastaFotos = Server.mapPath("/fotos")
		Server.scriptTimeout = 600
		
		if aspUpload.save(pastaTemporaria) = 1 then
			set arquivo = aspUpload.files(1)
			
			if uCase(arquivo.imageType) <> "JPG" and uCase(arquivo.imageType) <> "PNG" then
				exibirMensagem("Tipo inválido. Somente imagens do tipo 'JPG' e 'PNG' são aceitos.")
			else
				set aspJpeg = Server.createObject("Persits.Jpeg")
				aspJpeg.open(arquivo.path)
				
				if aspJpeg.originalWidth < LARGURA_FOTO or aspJpeg.originalHeight < ALTURA_FOTO then
					exibirMensagem("Tamanho inválido. O tamanho mínimo permitido da foto é de '" & LARGURA_FOTO & "x" & ALTURA_FOTO & "' pixels.")
				else
					set foto = new Foto
					foto.codigoFoto = obterProximoCodigoFoto()
					foto.nomeArquivo = "foto" & foto.codigoFoto & "." & lCase(arquivo.imageType)
					foto.nomeArquivoPrevia = "previa_" & foto.nomeArquivo
					foto.posicaoExibicao = foto.codigoFoto
					
					set aspJpeg = redimensionarImagem(aspJpeg, LARGURA_FOTO, ALTURA_FOTO)
					aspJpeg.save(pastaFotos & "/" & foto.nomeArquivo)
					set aspJpeg = redimensionarImagem(aspJpeg, LARGURA_PREVIA_FOTO, ALTURA_PREVIA_FOTO)
					aspJpeg.save(pastaFotos & "/" & foto.nomeArquivoPrevia)
					
					adicionarFoto(foto)
					exibirMensagem("Foto adicionada com sucesso.")
					set foto = nothing
				end if
				
				set aspJpeg = nothing
			end if
			
			arquivo.delete()
			set arquivo = nothing
		end if
		
		set aspUpload = nothing
		
	end sub
	
	public function obterFotosPublicadas()

		obterFotosPublicadas = obterFotos("SELECT * FROM Foto WHERE publicada = True ORDER BY posicaoExibicao ASC")
		
	end function

	public function obterTodasFotos()

		obterTodasFotos = obterFotos("SELECT * FROM Foto ORDER BY posicaoExibicao ASC")
		
	end function
	
	public sub excluirFoto(codigoFoto)
	
		dim conexao, fotos, foto, arquivo, pastaFotos
		fotos = obterFotos("SELECT * FROM Foto WHERE codigoFoto = " & codigoFoto)
		
		if uBound(fotos) = 0 then
			set foto = fotos(0)
			set conexao = obterConexao()
			conexao.execute("DELETE FROM Foto WHERE codigoFoto = " & codigoFoto)
			conexao.execute("UPDATE Foto SET posicaoExibicao = posicaoExibicao - 1 WHERE posicaoExibicao > " & foto.posicaoExibicao)
			conexao.close()
			set arquivo = Server.createObject("Scripting.FileSystemObject")
			pastaFotos = Server.mapPath("/fotos")
			arquivo.getFile(pastaFotos & "/" & foto.nomeArquivo).delete()
			arquivo.getFile(pastaFotos & "/" & foto.nomeArquivoPrevia).delete()
			exibirMensagem("Foto excluída com sucesso.")
			set arquivo = nothing
		end if
		
		set fotos = nothing
		set conexao = nothing
		
	end sub
	
	public sub moverFoto(codigoFoto, posicaoExibicaoAtual, posicaoExibicaoNova)
	
		dim conexao
		set conexao = obterConexao()
		conexao.execute("UPDATE Foto SET posicaoExibicao = " & posicaoExibicaoAtual & " WHERE posicaoExibicao = " & posicaoExibicaoNova)
		conexao.execute("UPDATE Foto SET posicaoExibicao = " & posicaoExibicaoNova & " WHERE codigoFoto = " & codigoFoto)
		conexao.close()
		set conexao = nothing
		
	end sub
	
	public sub ocultarFoto(codigoFoto)
	
		publicarOcultarFoto codigoFoto, "FALSE", "ocultada"
		
	end sub
	
	public sub publicarFoto(codigoFoto)
	
		publicarOcultarFoto codigoFoto, "TRUE", "publicada"
		
	end sub
	
	private sub publicarOcultarFoto(codigoFoto, publicada, acao)
	
		if isNumeric(codigoFoto) then
			executarComando("UPDATE Foto SET publicada = " & publicada & " WHERE codigoFoto = " & codigoFoto)
			exibirMensagem("Foto " & acao & " com sucesso.")
		end if
		
	end sub
	
	private function obterProximoCodigoFoto()
	
		dim conexao, recordset, codigoFoto
		set conexao = obterConexao()
		set recordset = conexao.execute("SELECT MAX(codigoFoto) + 1 AS codigo FROM Foto")
		
		if not isNumeric(recordset("codigo")) then
			codigoFoto = cInt(1)
		else
			codigoFoto = cInt(recordset("codigo"))
		end if
		
		recordset.close()
		conexao.close()
		set recordset = nothing
		set conexao = nothing
		
		obterProximoCodigoFoto = codigoFoto
		
	end function
	
	private sub adicionarFoto(foto)
	
		executarComando("INSERT INTO Foto("_
			& "codigoFoto, "_
			& "nomeArquivo, "_
			& "nomeArquivoPrevia, "_
			& "publicada, "_
			& "posicaoExibicao) VALUES("_
			& foto.codigoFoto & ", "_
			& "'" & foto.nomeArquivo & "', "_
			& "'" & foto.nomeArquivoPrevia & "', "_
			& "FALSE, "_
			& foto.posicaoExibicao & ")")
			
	end sub
	
	private function obterFotos(instrucaoSql)

		dim conexao, recordset, fotos(), foto
		set conexao = obterConexao()
		set recordset = conexao.execute(instrucaoSql)
		
		if not recordset.eof then
			redim fotos(recordset.recordCount - 1)
			
			while not recordset.eof
				set foto = new Foto
				foto.codigoFoto = cInt(recordset("codigoFoto"))
				foto.nomeArquivo = cStr(recordset("nomeArquivo"))
				foto.nomeArquivoPrevia = cStr(recordset("nomeArquivoPrevia"))
				foto.publicada = cBool(recordset("publicada"))
				foto.posicaoExibicao = cInt(recordset("posicaoExibicao"))
				set fotos(recordset.absolutePosition - 1) = foto
				recordset.moveNext()
			wend
		end if
		
		recordset.close()
		conexao.close()
		set recordset = nothing
		set conexao = nothing
		
		obterFotos = fotos
		
	end function
	
	private function redimensionarImagem(imagem, larguraLimite, alturaLimite)
	
		if imagem.width > larguraLimite then
			imagem.height = imagem.height * larguraLimite / imagem.width
			imagem.width = larguraLimite
		end if
		
		if imagem.height > alturaLimite then
			imagem.width = imagem.width * alturaLimite / imagem.height
			imagem.height = alturaLimite
		end if
		
		set redimensionarImagem = imagem
		
	end function
	
%>
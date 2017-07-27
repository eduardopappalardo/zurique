<!-- #include virtual="/lib/lib.asp" -->
<%

	dim regExp, nome, email, mensagem, mensagemUsuario, concatenador, teclaEnter, destinatarios(2)
	
	teclaEnter = chr(10) & chr(13)
	nome = trim(Request.form("nome"))
	email = trim(Request.form("email"))
	mensagem = trim(Request.form("mensagem"))
	mensagemUsuario = ""
	concatenador = ""
	
	if len(nome) = 0 then
		mensagemUsuario = " - O campo 'Nome' é obrigatório."
		concatenador = teclaEnter
	end if
	
	if len(email) = 0 then
		mensagemUsuario = mensagemUsuario & concatenador & " - O campo 'E-mail' é obrigatório."
		concatenador = teclaEnter
	else
		set regExp = new RegExp
		regExp.pattern = "^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,6})$"
		
		if not regExp.test(email) then
			mensagemUsuario = mensagemUsuario & concatenador & " - O campo 'E-mail' não é válido."
			concatenador = teclaEnter
		end if
	end if
	
	if len(mensagem) = 0 then
		mensagemUsuario = mensagemUsuario & concatenador & " - O campo 'Mensagem' é obrigatório."
	end if
	
	if len(mensagemUsuario) > 0 then
		Response.write(mensagemUsuario)
		Response.end()
	end if
	
	on error resume next
	
		destinatarios(0) = "faleconosco@zuriquebolos.com.br"
		destinatarios(1) = "eduardopappalardo@yahoo.com.br"
		destinatarios(2) = "solange.pappalardo@ig.com.br"
		
		enviarEmail email, destinatarios, "Zurique Bolos - Fale Conosco", ("<html><body><b>Nome:</b> " & nome & "<br /><b>E-mail:</b> " & email & "<br /><b>Mensagem:</b> " & mensagem & "</body></html>")
		
		if Err.number <> 0 then
			mensagemUsuario = "Falha ao enviar mensagem!" & teclaEnter & "Por favor tente novamente mais tarde."
		else
			mensagemUsuario = "Mensagem enviada com sucesso!" & teclaEnter & "Em breve retornaremos o contato."
		end if
		
		Response.write(mensagemUsuario)
	
	on error goTo 0
	
%>
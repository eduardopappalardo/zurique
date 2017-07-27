<%

	public sub enviarEmail(remetente, destinatarios, assunto, mensagem)

		dim aspEmail, destinatario
		set aspEmail = Server.createObject("Persits.MailSender")
		aspEmail.host = "mail.weblocal.com.br"
		aspEmail.from = remetente
		
		for each destinatario in destinatarios
			aspEmail.addAddress(destinatario)
		next
		aspEmail.subject = assunto
		aspEmail.body = mensagem
		aspEmail.isHtml = true
		aspEmail.send()
		set aspEmail = nothing
		
	end sub
	
	public sub exibirMensagem(mensagem)
	
		Response.write("<script>alert('" & replace(mensagem, "'", "\'") & "');</script>")
		
	end sub
	
	public sub executarComando(instrucaoSql)
	
		dim conexao
		set conexao = obterConexao()
		conexao.execute(instrucaoSql)
		conexao.close()
		set conexao = nothing
		
	end sub
	
	public function obterConexao()

		dim conexao
		set conexao = Server.createObject("ADODB.Connection")
		conexao.connectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Jet OLEDB:Database Password=zuriqueb0l0$;Data Source=" & Server.mapPath("/banco/zurique.mdb") & ";"
		conexao.cursorLocation = 3
		conexao.open()
		set obterConexao = conexao
		
	end function
	
%>
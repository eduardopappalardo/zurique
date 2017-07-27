<!-- #include file="validaSessao.asp" -->
<!-- #include virtual="/lib/foto.asp" -->
<%

	if uCase(Request.serverVariables("REQUEST_METHOD") = "POST") then
		set regExp = new RegExp
		regExp.pattern = "^multipart/form-data;.*$"
		
		if regExp.test(Request.serverVariables("CONTENT_TYPE")) then
			salvarFoto()
		elseif Request.form("acao") = "Ocultar" then
			ocultarFoto(Request.form("codigoFoto"))
			
		elseif Request.form("acao") = "Publicar" then
			publicarFoto(Request.form("codigoFoto"))
			
		elseif Request.form("acao") = "<< Mover" then
			moverFoto Request.form("codigoFoto"), Request.form("posicaoExibicao"), (cInt(Request.form("posicaoExibicao")) - 1)
			
		elseif Request.form("acao") = "Mover >>" then
			moverFoto Request.form("codigoFoto"), Request.form("posicaoExibicao"), (cInt(Request.form("posicaoExibicao")) + 1)
			
		elseif Request.form("acao") = "Excluir" then
			excluirFoto(Request.form("codigoFoto"))
		end if
	end if
	
%>
<html>

	<head>
		<title>Zurique - Administrar fotos</title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<script type="text/javascript" src="../js/jquery-1.6.2.min.js"></script>
		<script type="text/javascript" src="../js/jquery.blockUI.js"></script>
		<script type="text/javascript" src="../js/jquery.lightbox-0.5.min.js"></script>
		<script type="text/javascript" src="js/default.js"></script>
		<link rel="stylesheet" type="text/css" href="../css/jquery.lightbox-0.5.css" />
		<link rel="stylesheet" type="text/css" href="css/estilo.css" />
	</head>
	
	<body>
	
		<div id="corpo">
		
			<!--<div id="menu">
				<a href="javascript:exibirConteudo('#quemSomos');"><span style="margin-left: 0px;">Administrar fotos</span></a>
			</div>-->
			
			<div id="conteudo">
			
				<form action="" method="post" enctype="multipart/form-data" onsubmit="$.blockUI();">
					<input type="file" name="arquivo" />
					<input type="submit" value="Enviar" />
				</form>
				<br />
				<%
					dim fotos, cont
					fotos = obterTodasFotos()
					
					for cont = lBound(fotos) to uBound(fotos)
						Response.write("<div style='width:155px; height:340px; float:left; margin:3px; text-align:center; border:2px solid rgb(70%, 30%, 30%);'>")
						Response.write("<div style='width:155px; height:100px; padding-top:10px;'>")
						Response.write("<a href='../fotos/" & fotos(cont).nomeArquivo & "'><img src='../fotos/" & fotos(cont).nomeArquivoPrevia & "' /></a>")
						Response.write("<br />" & fotos(cont).nomeArquivo & "</div>")
						Response.write("<form action='' method='post'>")
						Response.write("<input type='hidden' name='codigoFoto' value='" & fotos(cont).codigoFoto & "' />")
						Response.write("<input type='hidden' name='posicaoExibicao' value='" & fotos(cont).posicaoExibicao & "' />")
						
						if fotos(cont).publicada then
							Response.write("<br /><input type='submit' name='acao' value='Ocultar' />")
						else
							Response.write("<br /><input type='submit' name='acao' value='Publicar' />")
						end if
						
						if cont > 0 then
							Response.write("<br /><br /><input type='submit' name='acao' value='<< Mover' />")
						end if
						
						if cont < uBound(fotos) then
							Response.write("<br /><br /><input type='submit' name='acao' value='Mover >>' />")
						end if
						
						if Session("administrador") = true then
							Response.write("<br /><br /><input type='submit' name='acao' value='Excluir' />")
						end if
						Response.write("</form></div>")
					next
					
					set fotos = nothing
				%>
			</div>
			
		</div>
		
	</body>
	
</html>
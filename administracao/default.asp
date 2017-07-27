<!-- #include virtual="/lib/lib.asp" -->
<%

	Session("autenticado") = false
	Session("administrador") = false
	
	if Request.form("acao") = "autenticar" then
	
		if (Request.form("usuario") = "eduardo" and Request.form("senha") = "zuriqueb0l0$")_
		or (Request.form("usuario") = "leigos" and Request.form("senha") = "zuriqueb0l0$") then
			Session("autenticado") = true
			
			if Request.form("usuario") = "eduardo" then
				Session("administrador") = true
			end if
			Response.redirect("administraFotos.asp")
		else
			exibirMensagem("Usuário e/ou senha inválido(s).")
		end if
		
	end if
	
%>

<html>

	<head>
		<title>Zurique</title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<script type="text/javascript" src="../js/jquery-1.6.2.min.js"></script>
		<script type="text/javascript" src="js/default.js"></script>
		<link rel="stylesheet" type="text/css" href="css/estilo.css" />
	</head>
	
	<body style="text-align: center;">
	
		<div id="corpo">
		
			<div id="conteudo">
	
				<form action="" method="post">
					<input type="hidden" name="acao" value="autenticar" />
					<br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
					<label>Usuário:&nbsp;</label><input type="text" name="usuario" />
					<br /><br />
					<label>Senha:&nbsp;&nbsp;&nbsp;&nbsp;</label><input type="password" name="senha" />
					<br /><br />
					<input type="submit" value="Acessar" />
				</form>
				
			</div>
			
		</div>
		
	</body>
	
</html>
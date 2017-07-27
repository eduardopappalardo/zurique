<!-- #include file="validaSessao.asp" -->
<!-- #include virtual="/lib/freeaspupload.asp" -->
<%

	dim upload, fileSystemObject, folder, file, caminhoRelativoArquivos, caminhoAbsolutoArquivos
	
	Server.scriptTimeout = 600
	caminhoRelativoArquivos = "arquivos"
	caminhoAbsolutoArquivos = Server.mapPath(caminhoRelativoArquivos)
	set upload = new FreeASPUpload
	upload.save(caminhoAbsolutoArquivos)
	
%>

<html>

	<head>
		<title>Envia Arquivo</title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<style>
			table, table tr td {
				border: 1px solid black;
			}
		</style>
	</head>
	
	<body style="text-align: center;">
	
		<form action="" method="post" enctype="multipart/form-data">
			<input type="file" name="arquivo" />
			<input type="submit" value="Enviar" />
		</form>
		
		<h1>Arquivos</h1>
		<table style="margin: auto;">
			<tr><td>Nome arquivo</td><td>Tamanho(KB)</td><td>Tamanho(MB)</td><td>Data criação</td></tr>
			<%
			
				set fileSystemObject = Server.createObject("Scripting.FileSystemObject")
				set folder = fileSystemObject.getFolder(caminhoAbsolutoArquivos)
				
				for each file in folder.files
					Response.write("<tr><td><a href='" & caminhoRelativoArquivos & "/" & file.name & "'>" & file.name & "</a></td><td>" & formatNumber((file.size / 1024), 2) & "</td><td>" & formatNumber((file.size / (1024 * 1024)), 2) & "</td><td>" & file.dateCreated & "</td></tr>")
				next
				
				set folder = nothing
				set fileSystemObject = nothing
				
			%>
		<table>
		
	</body>
	
</html>
<!-- #include virtual="/lib/foto.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns:fb="http://ogp.me/ns/fb#">

	<head>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<meta name="title" content="Zurique Bolos" />
		<meta name="description" content="Bolos decorados para festas" />
		<meta name="keywords" content="bolo, bolo decorado, salgado, aniversário, casamento, buffet, festa, encomenda" />
		<title>Zurique - Bolos decorados para festas</title>
		<script type="text/javascript" src="js/jquery-1.6.2.min.js"></script>
		<script type="text/javascript" src="js/jquery.blockUI.js"></script>
		<script type="text/javascript" src="js/jquery.lightbox-0.5.min.js"></script>
		<script type="text/javascript" src="js/default.js"></script>
		<script type="text/javascript" src="js/facebook.js"></script>
		<link rel="stylesheet" type="text/css" href="css/jquery.lightbox-0.5.css" />
		<link rel="stylesheet" type="text/css" href="css/estilo.css" />
	</head>
	
	<body>
	
		<div id="fb-root"></div>
		
		<div id="corpo">
		
			<div id="cabecalho"></div>
			
			<div id="menu">
				<a href="javascript:exibirConteudo('#quemSomos');"><span style="margin-left: 0px;">Quem somos</span></a>
				<a href="javascript:exibirConteudo('#produtos');"><span>Produtos</span></a>
				<a href="javascript:exibirConteudo('#fotos');"><span>Fotos</span></a>
				<a href="javascript:exibirConteudo('#faleConosco');"><span>Fale conosco</span></a>
			</div>
			
			<div id="conteudo">
			
				<div id="quemSomos">
					<h1>Quem somos</h1>
					<br />
					<div class="quemSomosTexto">
						<p>A Zurique iniciou suas atividades em 1986 com a fabricação de chocolates, destacando-se na produção de ovos de Páscoa. Em 1993 inaugurou sua loja na Vila Galvão, em Guarulhos.</p>
						<p>Acompanhando a expansão e a diversificação do mercado, a Zurique desenvolveu novos produtos, mantendo sua produção artesanal minuciosa. Entre esses produtos destacam-se os bolos, doces, sorvetes e salgados, preparados com ingredientes selecionados e com sabor inovador.</p>
						<p>O seu objetivo principal de manter a qualidade, sabor e beleza dos seus produtos é ponto primordial em sua produção.</p>
					</div>
					<div><img src="imagem/loja1.png" alt="" /></div>
				</div>
				
				<div id="produtos">
					<h1>Produtos</h1>
					<br />
					<div class="produtosTexto">
						<ul>
							<li>Somos especializados na fabricação de bolos decorados, dos mais variados tamanhos e sabores.<br /><br /></li>
							<li>Aceitamos encomendas de bolos, doces e salgados para festas de casamento e aniversário.<br /><br /></li>
							<li>Em nossa loja temos uma grande variedade de bolos decorados para pronta entrega.<br /><br /></li>
							<li>Caso tenha dúvidas em relação as necessidades de sua festa, entre em contato conosco. Orientaremos com total transparência e dedicação.</li>
						</ul>
					</div>
					<div><img src="imagem/loja2.png" alt="" /></div>
				</div>
				
				<div id="fotos">
					<h1>Fotos</h1>
					<br />
					<%
						dim varFoto
						
						for each varFoto in obterFotosPublicadas()
							Response.write("<a href='fotos/" & varFoto.nomeArquivo & "'><img src='fotos/" & varFoto.nomeArquivoPrevia & "' alt='' /></a>")
						next
					%>
				</div>
				
				<div id="faleConosco">
					<h1>Fale conosco</h1>
					<br />
					<form action="" id="formFaleConosco">
						<label>Nome:</label>
						<input type="text" name="nome" size="40" maxlength="40" />
						<br /><br />
						<label>E-mail:</label>
						<input type="text" name="email" size="40" maxlength="40" />
						<br /><br />
						<label>Mensagem:</label><br />
						<textarea name="mensagem" cols="55" rows="8"></textarea>
						<br /><br />
						<input type="submit" value="Enviar" />
					</form>
				</div>
				
			</div>
			
			<div id="rodape">
				Avenida São Bento, n° 1714
				<br />Vila Galvão - Guarulhos - São Paulo
				<br />(11) 8286-1979 / (11) 8513-2008
			</div>
			
			<div id="facebook">
				<fb:like href="http://www.zuriquebolos.com.br" send="true" show_faces="true"></fb:like>
			</div>
			
		</div>
		
	</body>
	
</html>
var conteudoAtual = "#quemSomos";
			
function exibirConteudo(conteudoSelecionado) {

	if(conteudoSelecionado != conteudoAtual) {
		$(conteudoAtual).hide(
			"slow",
			function() {
				$(conteudoSelecionado).show("slow");
			}
		);
		conteudoAtual = conteudoSelecionado;
	}
}
$(document).ready(
	function() {
	
		$("#menu a span").hover(
			function() {
				$(this).addClass("menuFocado");
			},
			function() {
				$(this).removeClass("menuFocado");
			}
		);
		$("#fotos a img").hover(
			function() {
				$(this).addClass("fotoFocada");
			},
			function() {
				$(this).removeClass("fotoFocada");
			}
		);
		$("#formFaleConosco").submit(
			function() {
				$.ajax({
					url: "enviaEmail.asp"
					, type: "post"
					, data: $(this).serialize()
					, timeout: 10000
					, beforeSend: function() {
						$.blockUI();
					}
					, success: function(dados) {
					
						/*if(dados == "Mensagem enviada com sucesso!") {
							$("#formFaleConosco input[type=submit]").remove();
						}*/
						$.unblockUI({
							onUnblock: function() {
								alert(dados);
							}
						});
					}
					, error: function() {
						$.unblockUI({
							onUnblock: function() {
								alert("Falha ao enviar mensagem!\nPor favor tente novamente mais tarde.");
							}
						});
					}
				});
				return false;
			}
		);
		$("#conteudo").before("<div class='conteudoTopo'></div>").after("<div class='conteudoRodape'></div>");
		$("input[type='text'], input[type='password'], textarea").addClass("inputTexto");
		$("input[type='button'], input[type='submit']").addClass("inputBotao");
		$("#fotos a").lightBox();
		$("#conteudo > div").hide();
		$(conteudoAtual).show();
	}
);
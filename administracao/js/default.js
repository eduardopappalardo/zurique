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
		$("input[type='text'], input[type='password'], textarea").addClass("inputTexto");
		$("input[type='button'], input[type='submit']").addClass("inputBotao");
		$("a").lightBox();
	}
);
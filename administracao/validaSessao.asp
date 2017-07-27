<%

	if not Session("autenticado") = true then
		Response.redirect("default.asp")
	end if
	
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Compre e Venda</title>
</head>
<body>
<table width="100%" bgcolor="#828282" class="colapsed" cellpadding="10">
	<tr>
		<td>
		<div align="center"><img src="siteImagens/headerErro.jpg"></div>
		</td>
	</tr>
</table>

<div align="center">
<table width="1000">
	<tr>
		<td>
		<div align="center">
		<label style="color: #3A5FCD; font-size: large;">
		
		<br/><br/>
		<font size="5">Ol&aacute; ${nome}, <br/><br/>
		Ocorreu um erro inesperado ao tentar redirecionar para o seu perfil, 
		<a href="index.jsp">clique aqui</a> e fa&ccedil;a seu login.</font>
		<br/><br/>
		Por favor, ajude-nos a resolver este problema o mais r&aacute;pido poss&iacute;vel.
		<br/>
		Envie-nos um email com o c&oacute;digo <b>${codigo}</b> para podermos apurrar este erro.
		<br/><br/>
		A equipe do Compre e Venda agrade&ccedil;e sua compreens&atilde;o, e pede desculpas pelo
		transtorno.
		</label>
		</div>
		<br/><br/>		
		<div align="center">
		<a href="mailto:compreevendadetudo@gmail.com?Subject=feedback de erro">
		<img src="siteImagens/btenviar.png" alt="Enviar Email" title="Envir Email"></img></a>
		</div>
		<br/>
		<div align="left">
			<a href="index.jsp">		
			<img src="siteImagens/btvoltar.png" alt="Voltar para HomePage!" title="Voltar para HomePage!"></a>
		</div>
		</td>
	</tr>
</table>
</div>
<br/>
<table width="100%" bgcolor="#828282" class="colapsed" cellpadding="3">
	<tr>
		<td>
			<div align="center">
			<img alt="rodape. 2011 compra e venda .com .br !" src="siteImagens/rodape.jpg" /></div>
		</td>
	</tr>
</table>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Compre e Venda - Senha</title>
<style type="text/css">
.campoDeInput{
border: 2px solid #4F4F4F;
}
.labelDeInput {
color: #363636; 
font-size: large;
}
</style>
</head>
<body>

<table width="100%" bgcolor="#828282" class="colapsed" cellpadding="3">
	<tr>
		<td>
			<div align="center">
			<img alt="Recuperação de Senha !" src="siteImagens/headerRecSenha.jpg"></div>
		</td>
	</tr>
</table>

<c:choose>
	<c:when test="${empty msgEnviado}">
	<div align="center">
<table width="1000">
<tr>
<td>
	<br/><br/>
	<p align="center"><label style="color: #3A5FCD; font-size: large;">
	Para efetuar a recupera&ccedil;&atilde;o de seu usu&aacute;rio e senha &eacute; 
	obrigat&oacute;rio o prenchimento do e-mail utilizado em seu cadastro !</label></p>
	<br/>	
</td>
</tr>

<tr>
<td align="center">
	<c:if test="${not empty msgEmail}">
		<p align="center">
		<label style="color: #CD0000; font-size: small; font-weight: bold">${msgEmail}</label></p>
	</c:if>
	<c:if test="${empty msgEmail}">
		<p style="color: white;">texto nulo para fins de formatação</p>
	</c:if>	
	<form action="RecuperarSenhaServlet" method="post" name="cadSenha">
	<label class="labelDeInput"> email </label>				
	<input type="text" name="email" value="${email}" class="campoDeInput" size="50"/>
	<br/><br/>
	<a href="#" onclick="document.cadSenha.submit();">		
		<img src="siteImagens/btrecuperarsenha2.png" alt="recuperar login !" title="recuperar login!" />
	</a>
	</form>
	<br/>			
</td>
</tr>
</table>
</div>
	</c:when>
	<c:otherwise>
	<br/><br/>
	<p align="center">
	<label style="color: #3A5FCD; font-size: x-large; font-style: italic">${email}</label></p>
	<p align="center">
	<label style="color: #3A5FCD; font-size: large;">	
	Uma mensagem foi enviada ao seu e-mail<br/><br/>
	Verifique sua caixa de entrada para recuperar seu usu&aacute;rio e senha!<br/><br/>
	Atenciosamente,<br/>
	Equipe Compra e Venda.</label></p>
	<br/><br/>
	</c:otherwise>
</c:choose>


<div align="center">
	<table width="1000">
		<tr>
			<td>
				<div align="left">
					<a href="index.jsp">		
					<img src="siteImagens/btvoltar.png" alt="Voltar para HomePage!" title="Voltar para HomePage!" />
					</a>
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
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="br.com.compraevenda.modelo.Cliente"%>
<%@page import="br.com.compraevenda.modelo.Produto"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Compre e Venda - Produto</title>
<style type="text/css">
.campoDeInput{
border: 2px solid #4F4F4F;
}
.labelDeInput {
color: #363636; 
font-size: large;
}
.dadosAlterados {
	font-family: serif;
	font-size: medium;
	font-weight: bold;
	color: green;
}
a {
text-decoration: none;
color: white;
}
img {
border: 2px;
}
</style>
</head>
<body>

<div align="center">
<table width="100%">
	<tr>
		<td>
		<table width="100%" bgcolor="#828282" class="colapsed" cellpadding="3">
			<tr>
				<td>
				<div align="center">
				<img alt="Cadastro de Produto !" src="siteImagens/headerProduto.jpg"></div>
				</td>
			</tr>
		</table>
		<br/>
		<table width="1000" align="center" bgcolor="#828282">
			<tr>
				<td align="left" width="60">
					<img width="50" height="50" alt="${cliente.nome}"
					src="CarregarImagemServlet?id=${cliente.urlImagem}" />
				</td>
				<td align="left">
					<label style="color: white; font-family: serif;">Ol&aacute;, ${cliente.nome} !</label>
				</td>
				<td align="right">
					<label style="color: white; font-family: serif;"><b><a href="LogoutServlet">SAIR !</a></b></label>
				</td>
			</tr>
		</table>
		
		<c:if test="${not empty emailEnviado}">
			<div align="center">
			<div align="center" class="dadosAlterados"><br/>Sua Mensagem foi enviada com Sucesso !</div>
			</div>
		</c:if>
				
		<hr align="center" width="900" />
		
		<div align="center">
		<table width="1000" cellpadding="5" bgcolor="#E6E8FA">			
			<tr>
				<td align="right">
				<div class="labelDeInput">Postado em </div>
				<label style="color: #4F4F4F; font-family: serif; font-size: xx-large;">${produto.dataFormatada}</label></td>				
			</tr>
			<tr>
				<td align="left">
				<label class="labelDeInput">Quero ${produto.interesse}</label></td>				
			</tr>
			<tr>
				<td align="left">
				<label style="color: #4F4F4F; font-family: serif; font-size: x-large;">${produto.nome}</label></td>				
			</tr>						
			<tr>
				<td align="left">
				<label style="color: #483D8B; font-family: serif; font-size: large;">${produto.descricao}</label></td>				
			</tr>			
			<tr>
				<td align="left">
				<label style="color: #8B4513; font-family: serif; font-size: xx-large;">R$ ${produto.preco}</label></td>				
			</tr>
		</table>
		</div>
		
		<hr align="center" width="900" />		
			
		<table width="900" align="center">
		<tr>
		<c:forEach items="${produto.imagens}" var="imagem">
			<c:if test="${imagem.foto}">
				<td width="225" align="center">
				<a href="upload.jsp?id=${imagem.urlImagem}" target="_blank">
				<img src="CarregarImagemServlet?id=${imagem.urlImagem}" width="100" height="100" 
				     alt="clique para ampliar" title="clique para ampliar"/></a><br/>
				</td>
			</c:if>		
		</c:forEach>
		</tr>											
		</table>
	</td>
</tr>
</table>

<table>
	<tr>
		<td>
		
		</td>
	</tr>
</table>		
			
<hr align="center" width="900" />
			
	<div align="center">
	<table width="1000">
		<tr>			
			<% 
			Cliente c = (Cliente) session.getAttribute("cliente");
			Produto p = (Produto) request.getAttribute("produto");
			if (c.getIdcliente() != p.getCliente().getIdcliente()){			
			%>
			<td width="90" bgcolor="#4F4F4F">
			<div align="center">
			<img alt="${produto.cliente.nome}" title="${produto.cliente.nome}" width="80" height="100"
			     src="CarregarImagemServlet?id=${produto.cliente.urlImagem}" />	
			</div>		
			</td>
			
			<td width="">
				<label class="labelDeInput">${produto.cliente.nome} quer ${produto.interesse} este produto !</label>
			</td>
			
			<td width="200">			
			<div align="right">			
			<label class="labelDeInput"> Fa&ccedil;a sua oferta para o produto</label><br/>
			<form action="EnviarMensagemServlet" method="post" name="formProposta">
			<input type="hidden" name="perfil" value="false"/>
			<input type="hidden" name="produto" value="true"/>			
			<input type="hidden" name="idProduto" value="${produto.idproduto}">					
			<textarea rows="5" cols="50" name="mensagem" class="campoDeInput"></textarea>
			<a href="#" onclick="document.formProposta.submit();">
				<img alt="Enviar proposta !" title="Enviar proposta !" src="siteImagens/btenviar.png" />
			</a>
			</form>			
			</div>			
			</td>
			<%
			} else {
			%>
				<td align="right">
				<label style="style=color: #4F4F4F; font-family: serif; font-size: xx-large;">
					Seu Produto !				
				</label>
				</td>		
			<%	
			}
			%>									
		</tr>
	</table>
	</div>
	
	<div align="center">
	<table width="1000">
		<tr>
			<td align="left">
			<a href="javascript:history.go(-1)">		
					<img src="siteImagens/btvoltar.png" 
					     alt="Voltar para HomePage!" 
					     title="Voltar para HomePage!"></a>
			</td>
		</tr>
	</table>
	</div>			
								
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
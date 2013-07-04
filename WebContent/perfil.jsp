<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Compre e Venda - Perfil</title>
<style type="text/css">
.campoDeInput{
border: 2px solid #4F4F4F;
}
.labelDeInput {
color: #363636; 
font-size: large;
}
a {
text-decoration: none;
color: white;
}
.dadosAlterados {
	font-family: serif;
	font-size: medium;
	font-weight: bold;
	color: green;
}
</style>
</head>
<body>

<div align="center">
<table width="100%" bgcolor="gray" cellpadding="5">
	<tr>
		<td>
		<table width="100%" bgcolor="#828282" class="colapsed" cellpadding="3">
			<tr>
				<td>
				<div align="center">
				<img alt="Cadastro de Produto !" src="siteImagens/headerPerfil.jpg"></div>
				</td>
			</tr>
		</table>
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
				
		<hr align="center" width="900" />
		
		<div align="center">
		<table width="1000" cellpadding="5" bgcolor="#E6E8FA">			
			<tr>
				<td rowspan="7" align="center" width="150">				
				<img alt="${perfil.nome}" title="${perfil.nome}" 
				     src="CarregarImagemServlet?id=${perfil.urlImagem}" width="300" height="300"/>				     
				</td>
			</tr>					
			
			<tr>
				<td align="left">
				<label style="color: #4F4F4F; font-family: serif; font-size: xx-large;">
				Voc&ecirc; est&aacute; no perfil de </label><br/>
				<label style="color: #4F4F4F; font-family: serif; font-size: x-large;">
				${perfil.nome}</label></td>				
			</tr>
									
			<tr>
				<td align="left">
				<label style="color: #483D8B; font-family: serif; font-size: large;">
				${perfil.cidade} - ${perfil.estado}</label></td>				
			</tr>
			
			<c:if test="${perfil.autorizarEndereco}">
			<tr>
				<td align="left">
				<label style="color: #483D8B; font-family: serif; font-size: large;">
				${perfil.endereco}</label></td>				
			</tr>
			</c:if>
			
			<c:if test="${perfil.autorizarTelefone}">
			<tr>
				<td align="left">
				<label style="color: #483D8B; font-family: serif; font-size: large;">
				${perfil.telefone}</label></td>				
			</tr>
			</c:if>
			
			<tr>
				<td align="left">
				<label style="color: #483D8B; font-family: serif; font-size: large;">
				${perfil.email}</label></td>				
			</tr>
						
			<tr>
			<td align="right" valign="baseline">			
				<c:choose>
					<c:when test="${not empty perfil.redeSocial.facebook}">
						<a href="${perfil.redeSocial.facebook}" target="_blank">
						<img src="siteImagens/iconefacebook.png" alt="Me Encontre Aqui"
							title="Me Encontre Aqui"></img> </a>
					</c:when>
					<c:otherwise>
						<img src="siteImagens/iconefacebook.png" alt="Não tenho facebook"
							title="Não tenho facebook"></img>
					</c:otherwise>
				</c:choose>
				 
				<c:choose>
					<c:when test="${not empty perfil.redeSocial.twitter}">
						<a href="${perfil.redeSocial.twitter}" target="_blank">
						<img src="siteImagens/iconetwitter.png" alt="Siga-Me" title="Siga-Me"></img>
						</a>
					</c:when>
					<c:otherwise>
						<img src="siteImagens/iconetwitter.png" alt="Não tenho twitter"
							title="Não tenho twitter"></img>
					</c:otherwise>
				</c:choose> 
				
				<c:choose>
					<c:when test="${not empty perfil.redeSocial.orkut}">
						<a href="${perfil.redeSocial.orkut}" target="_blank"> 
						<img src="siteImagens/iconeorkut.png" alt="Visite Meu Perfil"
							title="Visite Meu Perfil"></img> </a>
					</c:when>
					<c:otherwise>
						<img src="siteImagens/iconeorkut.png" alt="Não tenho orkut"
							title="Não tenho orkut"></img>
					</c:otherwise>
				</c:choose>
			</td>				
			</tr>
		</table>
		</div>		
	
<br/>
<c:if test="${not empty emailEnviado}">
<div align="center">
<div align="center" class="dadosAlterados"><br/>Sua Mensagem foi enviada com Sucesso !</div>
</div>
</c:if>
<div align="center">
			<label style="color: #483D8B; font-family: serif; font-size: x-large;">
			Mande uma mensagem para ${perfil.nome}</label><br/>
			<form action="EnviarMensagemServlet" method="post" name="formMensagem">
			<input type="hidden" name="perfil" value="true"/>
			<input type="hidden" name="produto" value="false"/>
			<input type="hidden" name="id" value="${perfil.idcliente}">
			<input type="hidden" name="email" value="${perfil.email}"/>
			<textarea rows="5" cols="75" name="mensagem" class="campoDeInput"></textarea><br/>
			<a href="#" onclick="document.formMensagem.submit();">
				<img alt="Enviar mensagem !" title="Enviar mensagem !" src="siteImagens/btenviar.png">
			</a>
			</form>				
</div>
<br/>
<table width="1000" border="1">
<c:choose>
					<c:when test="${empty perfil.produtos}">
						<table cellpadding="5">
							<tr>
								<td>
								<div align="left">
								<label style="color: #4F4F4F; font-family: serif; font-size: x-large">
								<br />
								${perfil.nome} n&atilde;o cadastrou nenhum produto ainda !</label>
								</div>
								</td>
							</tr>
						</table>
						<hr align="center" width="900" />
						</c:when>
						
						<c:otherwise>
							<table cellpadding="5">
							<tr>
								<td>
								<div align="left">
								<label style="color: #4F4F4F; font-family: serif; font-size: xx-large">								
								Produto(s) de ${perfil.nome} !</label>
								<br/>
								</div>
								</td>
							</tr>
							</table>
							
							<c:forEach items="${perfil.produtos}" var="produto">
							
							<table cellpadding="5" bgcolor="#E8E8E8" cellspacing="5">															
								<tr>
									<td width="45" rowspan="3" bgcolor="#4F4F4F">
									<a href="VisualizarProdutoServlet?id=${produto.idproduto}">									
									<img width="90" height="90"
										src="CarregarImagemServlet?id=${produto.fotoPrincipal}" /></a>									
									</td>
									<td width="600">
									<label style="color: #4F4F4F; font-family: serif; font-size: x-large;">
									${produto.nome}</label></td>									
								</tr>
								<tr>
									<td><label style="color: #483D8B; font-family: serif; font-size: large;">
									${produto.descricao}</label>
									</td>									
								</tr>
								<tr>
									<td><label style="color: #8B4513; font-family: serif; font-size: larger">
									${produto.preco}</label></td>
									<td>
									<table width="100%" cellpadding="5">
										<tr></tr>
									</table>
									</td>
								</tr>							
							</table>
							
							<hr align="center" width="900" />
							</c:forEach>							
						</c:otherwise>
					</c:choose>	
</table>
			
	<div align="center">
	<table width="1000">
		<tr>
			<td width="500" align="left" valign="bottom">
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
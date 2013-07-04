<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Compre e Venda - Cadastro de Produto</title>
<style type="text/css">

.campoDeInput{
border: 2px solid #4F4F4F;
}
.labelDeInput {
color: #363636; 
font-size: large;
}
.labelDeInput2 {
color: #8B1A1A; 
font-size: large;
}
a {
text-decoration: none;
color: white;
}
</style>
</head>
<body>
<form action="AlterarProdutoServlet?busca=false" method="post" name="cadAlterCliente" enctype="multipart/form-data">
<div align="center">
<table width="100%">
	<tr>
		<td>
		<table width="100%" bgcolor="#828282" class="colapsed" cellpadding="3">
			<tr>
				<td>
				<div align="center">
				<img alt="Cadastro de Cliente" src="siteImagens/headerAlterDadosProduto.jpg"></div>
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
			
			<br/>
			<hr align="center" width="900" />
			<div align="center">
			<table width="1000" border="0">
				<tr>
					<td colspan="2" width="1000" align="center">						
							<label style="color: #CD0000; font-size: medium; font-weight: bold">
								Para alterar uma Informa&ccedil;&atilde;o de seu produto, 
								digite o novo valor no espa&ccedil;o ao lado do campo que deseja modificar !								
							</label>										
					</td>					
				</tr>
				<tr>
					<td width="500" align="right">
					<label class="labelDeInput">(nome) <b>${produto.nome}</b> </label></td>
					<td width="500" align="left">
					<input type="text" name="nome" value="${nome}" class="campoDeInput" size="50"/></td>
				</tr>
				
				<c:if test="${not empty msgPreco}">
				<tr><td colspan="2" width="1000">			
					<label style="color: #CD0000; font-size: small; font-weight: bold">
					(${msgPreco})N&atilde;o &eacute; um formato v&aacute;lido para o pre&ccedil;o !<br/>
					Utilize um valor no formato 999 ou 999.99 Ex. 2300 ou 2300.40.
					</label>
				</td></tr>			
				</c:if>						
				
				<tr>
					<td width="500" align="right">
					<label class="labelDeInput">(pre&ccedil;o) <b>${produto.preco}</b> </label></td> 
					<td width="500" align="left">
					<input type="text" name="preco" value="${preco}" class="campoDeInput" size="50"/>
				</tr>		
				
				<tr>
					<td width="500" align="right">
					<label class="labelDeInput">(descri&ccedil;&atilde;o) <b>${produto.descricao}</b> </label></td> 
					<td width="500" align="left">
					<textarea name="descricao" rows="10" cols="37" class="campoDeInput" >${descricao}</textarea>					
				</tr>
				
				<tr>
				<td align="right"><label class="labelDeInput">(interesse)
				</label></td>
				<td align="left">				
				<input type="radio" name="interesse"
					value="vender" class="labelDeInput" /><label class="labelDeInput">vender</label>
				<input type="radio" name="interesse"
					value=trocar class="labelDeInput" /><label class="labelDeInput">trocar</label>
				<input type="radio" name="interesse"
					value="vender ou trocar" class="labelDeInput" /><label class="labelDeInput">vender ou trocar</label>					
				</td>
				</tr>			
				
			</table>
			</div>
			
			<hr align="center" width="900" />
			
			<div align="center">
		<table width="1000" align="center" bgcolor="#F0FFFF" cellpadding="5">
			<tr>
			<td colspan="2" width="1000" align="center"><label class="labelDeInput">
			<font style="color: #3A5FCD;">Deseja alterar a categoria de seu produto?</font>
				</label></td>				
			</tr>
			<tr>
				<td width="500" align="right">
					<label class="labelDeInput">(categoria) <b>${produto.categoria.nome}</b></label></td> 
				<td width="500" align="left">
				<input type="text" name="categoria" value="${categoria}" class="campoDeInput" size="50" /></td>
			</tr>
		</table>
		</div>
				
			<hr align="center" width="900" />		
			
			<table width="1000" align="center" bgcolor="#F0FFFF" cellpadding="5">				
				<tr>
					<td colspan="4" width="1000" align="center">
						<c:if test="${not empty msgFoto}">
							<label style="color: #3A5FCD; font-size: small; font-weight: bold">
								Todos os arquivos devem ser foto .jpg ou .png !
							</label>
						</c:if>
						<c:if test="${empty msgFoto}">
							<label style="color: #3A5FCD; font-size: large;">
								Se desejar altera as fotos de seu produto, selecione as novas fotos!
							</label>
						</c:if>
					</td>
				</tr>
				
				<c:set var="default" value="produtoDefault.jpg"></c:set>
				<tr>
				<c:forEach items="${produto.imagens}" var="imagem">
					<td width="250" align="center">
					<img width="80" height="100" alt="foto de produto"
					src="CarregarImagemServlet?id=${imagem.urlImagem}" /><br/>
					<c:set var="nome" value="${imagem.urlImagem}"></c:set>	
					
						<c:if test="${fn:startsWith(nome, default)}">
							<label class="labelDeInput2">Nova foto ?</label><br/>
							<input type="file" name="fotoProduto" />
						</c:if>
						<c:if test="${ not fn:startsWith(nome, default)}">						
							<label class="labelDeInput2">Remover foto ?</label>
							<input type="checkbox" value="${imagem.urlImagem}" name="removerFoto"></input>
						</c:if>					
					</td>				
				</c:forEach>								
				</tr>				
			</table>
		</td>
	</tr>
</table>		
			
<hr align="center" width="900" />

<table>
	<tr>
		<td width="500" align="left"><a href="javascript:history.go(-1)"> 
		<img src="siteImagens/btvoltar.png" alt="Voltar para HomePage!"	title="Voltar para HomePage!"></a></td>
			
		<td width="500" align="right">
		<a href="#" onclick="document.cadAlterCliente.submit();">		
		<img src="siteImagens/btsalvar.png" alt="Salvar alterações !" title="Salvar alterações !"></a></td>
	</tr>
</table>
</div>
<input type="hidden" name="idProduto" value="${produto.idproduto}">
</form>

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
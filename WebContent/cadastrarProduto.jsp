<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Compre e Venda - Cadastro de  Produto</title>
<style type="text/css">
.campoDeInput{
border: 2px solid #4F4F4F;
}
.labelDeInput {
color: #363636; 
font-size: large;
font-weight: bold;
}
a {
text-decoration: none;
color: white;
}
</style>
</head>
<body>
<form action="CadastrarProdutoServlet" method="post" name="cadProduto" enctype="multipart/form-data">
<div align="center">
<table width="100%">
	<tr>
		<td>
		<table width="100%" bgcolor="#828282" class="colapsed" cellpadding="3">
			<tr>
				<td>
				<div align="center">
				<img alt="Cadastro de Produto !" src="siteImagens/headerCadProduto.jpg"></div>
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
		<table width="1000" cellspacing="0" cellpadding="5">
			<tr>
				<td colspan="2" width="1000" align="center"><c:if
					test="${not empty msgErro}">
					<label style="color: #CD0000; font-size: medium; font-weight: bold">
					Informa&ccedil;&otilde;es do produto. Preenchimento obrigat&oacute;rio !
					</label>
				</c:if> 
				<c:if test="${empty msgErro}">
					<label style="color: #FF7256; font-size: medium;">
					Informa&ccedil;&otilde;es do produto. Preenchimento obrigat&oacute;rio !
					</label>
				</c:if>
				<br/>
				<c:if test="${not empty msgPreco}">			
					<label style="color: #CD0000; font-size: small; font-weight: bold">
					(${msgPreco})N&atilde;o &eacute; um formato v&aacute;lido para o pre&ccedil;o !<br/>
					Utilize um valor no formato 999 ou 999.99 Ex. 2300 ou 2300.40.
					</label>			
				</c:if>
				</td>
			</tr>
			
			<tr>				
				<td width="500" align="right"><label class="labelDeInput">nome </label></td>
				<td width="500" align="left"><input type="text" name="nome"
					value="${produto.nome}" class="campoDeInput" size="50" /></td>
			</tr>		
			
			<tr>
				<td width="500" align="right"><label class="labelDeInput">pre&ccedil;o
				</label></td>
				<td width="500" align="left"><input type="text" name="preco"
					value="${produto.preco}" class="campoDeInput" size="50" /></td>
			</tr>
			
			<tr>
				<td width="500" align="right"><label class="labelDeInput">descri&ccedil;&atilde;o<br/>
				<i><font style="font-weight: normal">Caso voc&ecirc; tenha interesse em trocar este produto, n&atilde;o esque&ccedil;a 
				de indicar suas prefer&ecirc;ncias aqui.</font></i>
				</label></td>
				<td width="500" align="left"><textarea rows="10" cols="39,2"
					name="descricao" class="campoDeInput">${produto.descricao}</textarea>
				</td>
			</tr>
			
			<tr>
				<td width="500" align="right"><label class="labelDeInput">interesse
				</label></td>
				<td width="500" align="left">
				<input type="radio" name="interesse"
					value="vender" class="labelDeInput" checked="checked" /><label class="labelDeInput">vender</label>
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
			<td><div align="center">
			<label style="color: #483D8B; font-family: serif; font-size: large;">categoria </label>
			<select name="categoriaOpt" class="campoDeInput">							
					<c:forEach items="${categorias}" var="categoria">
					<option value="${categoria.nome}">${categoria.nome}</option>													
					</c:forEach>
															
			</select>
					
			<label style="color: #483D8B; font-family: serif; font-size: large;">
			N&atilde;o encontrou a categoria para o seu produto ?</label></div>
			</td>
			</tr>
			
			<tr>
			<td align="center"><label class="labelDeInput">
			<font style="color: #3A5FCD;">Ajude-nos a classificar o seu produto, qual
			categoria voc&ecirc; gostaria que fosse atribu&iacute;da ao seu produto?</font>
				</label></td>				
			</tr>
			<tr>
				<td width="500" align="center">
				<input type="text" name="novaCategoria"	value="${produto.categoria}" class="campoDeInput" size="50" /></td>
			</tr>
		</table>
		</div>
		
		
		
		<hr align="center" width="900" />		
			
			<table width="1000" align="center" bgcolor="#F0FFFF" cellpadding="5">
				<tr>
					<td colspan="4" width="1000" align="center">
					<label class="labelDeInput">
					<font style="color: #3A5FCD;">Escolha as fotos do seu produto, lembre-se que somente
					foto(s) no formato .jpg ou .png ser&aacute; aceita !</font>
					</label>
					</td>
				</tr>
				<tr>
					<td width="250" align="center"><label class="labelDeInput">foto 1 </label></td>
					<td width="250" align="center"><label class="labelDeInput">foto 2 </label></td>
					<td width="300" align="center"><label class="labelDeInput">foto 3 </label></td>
					<td width="250" align="center"><label class="labelDeInput">foto 4 </label></td>
				</tr>
				<tr>
					<td width="250" align="center">
					<img src="imagem/produtoDefault.jpg" width="100" height="100"/><br/>
					<input type="file" name="produto1"/></td>					
					<td width="250" align="center">
					<img src="imagem/produtoDefault.jpg" width="100" height="100"/><br/>
					<input type="file" name="produto2"/></td>
					<td width="250" align="center">
					<img src="imagem/produtoDefault.jpg" width="100" height="100"/><br/>
					<input type="file" name="produto3"/></td>
					<td width="250" align="center">
					<img src="imagem/produtoDefault.jpg" width="100" height="100"/><br/>
					<input type="file" name="produto4"/></td>
				</tr>				
				<tr>
					<td colspan="4" width="900" align="center">
						<c:if test="${not empty msgFoto}">
							<label style="color: #3A5FCD; font-size: small; font-weight: bold">
								arquivo(s) deve(m) ser uma foto .jpg ou .png !
							</label>
						</c:if>
					</td>
				</tr>				
		</table>
</table>

<hr align="center" width="900" />

<table width="100%" bgcolor="#E8E8E8" cellpadding="5"><tr><td>
<div align="center">
<pre>
<textarea rows="10" cols="100">
De acordo com item 7.

7. Conteúdo nos Serviços

    7.1 O usuário compreende que a responsabilidade integral por todas as informações (tais como arquivos de dados, texto escrito, fotografias) a que possa ter acesso como parte dos Serviços, ou através da utilização dos mesmos, é da pessoa que deu origem a esse conteúdo. Todas essas informações são denominadas “Conteúdo”.

    7.2 O usuário deverá estar ciente de que o Conteúdo que lhe é apresentado como parte dos Serviços, pode estar protegido por direitos de propriedade intelectual que são de propriedade dos anunciantes que fornecem esse Conteúdo ao Portal. O usuário não poderá efetuar modificação, aluguel, arrendamento, empréstimo, venda, distribuição ou criação de obras derivadas baseadas neste Conteúdo (no todo ou em parte), a menos que tenha sido especificamente autorizado a fazê-lo, através de um contrato em separado, pelo Portal ou pelos proprietários desse Conteúdo.

    7.3 O Portal se reserva o direito (mas não tem qualquer obrigação) de pré-selecionar, rever, marcar, filtrar, modificar, recusar ou remover qualquer ou todo Conteúdo de qualquer Serviço. O Portal irá remover qualquer conteúdos sexuais explícitos, racista ou pejorativo, que possa considerar ofensivo.

    7.4 O usuário compreende que, ao utilizar os Serviços, pode estar exposto a Conteúdo que possa considerar ofensivo, indecente ou censurável e que, a este respeito, utiliza os Serviços por sua conta e risco.

    7.5 O usuário concorda que será o único responsável (e que o Portal não tem qualquer responsabilidade perante o usuário ou terceiros) por qualquer Conteúdo que crie, transmita ou visualize enquanto utiliza os Serviços e pelas conseqüências das suas ações (incluindo qualquer perda ou dano que o Portal possa sofrer) resultantes disso.

Qualquer tipo de conteúdo de "agrida" o referido item 7, ou qualquer item do Termo de Serviço e Contrato será removido sem aviso prévio.

01 de maio de 2011.


</textarea><br/><br/>
</pre>
<input type="radio" name="termoDoContrato" value="true" checked="checked"/>
	<label class="labelDeInput">Li e aceito os termos de cadastro de produto !</label>
<br/>
<input type="radio" name="termoDoContrato" value="false" />
	<label class="labelDeInput">Li e n&atilde;o concordo, n&atilde;o quero mais cadastrar meu produto!</label>
</div><br/>
</td></tr></table>		
			
<hr align="center" width="900" />
			
			<table>
				<tr>
					<td width="500" align="left">
						<a href="cliente.jsp">		
						<img src="siteImagens/btvoltar.png" alt="Voltar para HomePage!" title="Voltar para HomePage!"></a>
					</td>
					
					<td width="500" align="right">					
						<a href="#" onclick="document.cadProduto.submit();">		
						<img src="siteImagens/btcadastrar2.png" alt="Cadastrar!" title="Cadastrar!"></a>
									
						<a href="#" onclick="document.cadProduto.reset();">		
						<img src="siteImagens/btlimpar.png" alt="Limpar Campos!" title="Limpar Campos!"></a>
					</td>					
				</tr>
			</table>						
</div>
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
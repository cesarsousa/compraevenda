<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="br.com.compraevenda.modelo.Cliente"%>
<%
	Cliente cliente = (Cliente) request.getSession().getAttribute("cliente");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Compre e Venda - Cliente</title>
<style type="text/css">
#semBorda {
	border: none;
}

.campoDeInput {
	border: 2px solid #4F4F4F;
}

a {
	text-decoration: none;
	color: white;
}

.login {
	font-family: serif;
	font-size: small;
	font-weight: bold;
	color: white;
}

.erro {
	font-family: serif;
	font-size: medium;
	font-weight: bold;
	color: red;
}

.bordaSolida {
	border: 2px solid #4F4F4F;
	border-collapse: collapse;
}

.colapsed {
	border-collapse: collapse;
}

.dadosAlterados {
	font-family: serif;
	font-size: medium;
	font-weight: bold;
	color: green;
}
</style>
<script>
	function enviar_formularioPessoa() {
		document.cadBuscaPessoa.submit();
	}

	function enviar_formularioProduto() {
		document.cadBuscaProduto.submit();
	}
</script>
</head>
<body>
<div align="center">
<table width="100%" bgcolor="#828282" class="colapsed" cellpadding="10">
	<tr>
		<td>
		<div align="center"><img src="siteImagens/headerSite.jpg"></div>
		</td>
	</tr>	
</table>
</div>
<br/>

<table width="100%" cellpadding="3" bgcolor="#B22222">
	<tr>	
		<td width="70">
		<a href="http://www.facebook.com/profile.php?id=100002435062222" target="_blank">
			<img src="siteImagens/iconefacebook.png" alt="Nos Encontre Aqui" title="Nos Encontre Aqui"></img></a>
		</td>
		
		<td width="70">
		<a href="http://twitter.com/#!/CompreVendaTudo" target="_blank">
			<img src="siteImagens/iconetwitter.png" alt="Siga-Nos" title="Siga-Nos"></img>
		</a>
		</td>
		
		<td width="70">
		<a href="http://www.orkut.com.br/Main#Profile?uid=17602698445387539579" target="_blank"> 
			<img src="siteImagens/iconeorkut.png" alt="Visite Nosso Perfil"
							title="Visite Nosso Perfil"></img>
		</a>
		</td>
		
		<td>
		<label style="color: white; font-family: serif; font-size: medium;"><b>Visite-nos em nossas redes sociais !</b></label>
		</td>
			
		
			<td width="250" align="right">
				<form action="LogoutServlet" name="logoutForm" method="post">
				<a href="#" onclick="document.logoutForm.submit();">
					<img src="siteImagens/btlogout.png" alt="Sair !" title="Sair !"></a></form>
				</td>			
		
	</tr>
	</table>

<c:if test="${not empty clienteAlterado}">
	<div align="center" class="dadosAlterados"><br />
	Altera&ccedil;&atilde;o realizada com Sucesso !</div>
</c:if>

<div align="center">
<table cellpadding="10">
	<tr>
		<td>

		<div align="center">
		<table width="1000" bgcolor="#4F4F4F" cellpadding="5">
			<tr>
				<td><img width="160" height="200" alt="${cliente.nome}"
					src="CarregarImagemServlet?id=${cliente.urlImagem}" /></td>
				<td bgcolor="white" width="100%"><label
					style="color: #4F4F4F; font-family: serif; font-size: xx-large">
				${cliente.nome}</label><br />
				<label
					style="color: #483D8B; font-family: serif; font-size: x-large;">
				${cliente.cidade} - ${cliente.estado}</label><br />
				<label
					style="color: #483D8B; font-family: serif; font-size: x-large;">
				${cliente.endereco}</label><br />
				<label
					style="color: #483D8B; font-family: serif; font-size: x-large;">
				${cliente.telefone}</label><br/>
				<label
					style="color: #483D8B; font-family: serif; font-size: x-large;">
				${cliente.email}</label>

				<div align="right"><c:choose>
					<c:when test="${not empty cliente.redeSocial.facebook}">
						<a href="${cliente.redeSocial.facebook}" target="_blank"> <img
							src="siteImagens/iconefacebook.png" alt="Me Encontre Aqui"
							title="Me Encontre Aqui"></img> </a>
					</c:when>
					<c:otherwise>
						<img src="siteImagens/iconefacebook.png" alt="Não tenho facebook"
							title="Não tenho facebook"></img>
					</c:otherwise>
				</c:choose> <c:choose>
					<c:when test="${not empty cliente.redeSocial.twitter}">
						<a href="${cliente.redeSocial.twitter}" target="_blank"> <img
							src="siteImagens/iconetwitter.png" alt="Siga-Me" title="Siga-Me"></img>
						</a>
					</c:when>
					<c:otherwise>
						<img src="siteImagens/iconetwitter.png" alt="Não tenho twitter"
							title="Não tenho twitter"></img>
					</c:otherwise>
				</c:choose> <c:choose>
					<c:when test="${not empty cliente.redeSocial.orkut}">
						<a href="${cliente.redeSocial.orkut}" target="_blank"> <img
							src="siteImagens/iconeorkut.png" alt="Visite Meu Perfil"
							title="Visite Meu Perfil"></img> </a>
					</c:when>
					<c:otherwise>
						<img src="siteImagens/iconeorkut.png" alt="Não tenho orkut"
							title="Não tenho orkut"></img>
					</c:otherwise>
				</c:choose></div>
				</td>
			</tr>
		</table>
		</div>

		<div align="center">
		<table width="1000" cellpadding="5">
			<tr>
				<td valign="top">
				<table width="500">
					<tr>
						<td>
						<div align="right"><label
							style="color: #4F4F4F; font-family: serif; font-size: large">
						Altere seus dados, senha ou foto aqui !<br />
						</label> <a href="alterarCliente.jsp"> <img
							src="siteImagens/btperfil.png" alt="edite seu perfil !"
							title="edite seu perfil !"> </a> <br />
						<br />
						<label style="color: #4F4F4F; font-family: serif; font-size: large">
						Cadastre um novo produto !<br />
						</label>
						
						<a href="cadastrarProduto.jsp"> 
						<img src="siteImagens/btcadProduto.png" alt="cadastrar produto" title="cadastrar produto">						
						</a>
						<br /><br />

						<c:if test="${not empty buscaProdutoSemParametro}">
							<div align="center">
							<label style="color: #CD0000; font-size: small; font-weight: bold">
							digite um produto que deseja buscar ! </label></div>
						</c:if>

						<fieldset><legend
							style="color: #4F4F4F; font-family: serif; font-size: large">
						Fa&ccedil;a sua busca por produtos</legend>
						<form action="BuscaServlet" method="post" name="cadBuscaProduto">
						<table width="400" background="siteImagens/inputproduto.png">
							<tr>
								<td>
								<div align="left"><input type="text" name="produto" class="campoDeInput" size="43"></div>
								<input type="hidden" name="optProduto" value="true">
								<input type="hidden" name="optPessoa" value="false">
								</td>
							</tr>
						</table>

						<table>
							<tr>
								<td width="200" align="center">
								<label style="color: #483D8B; font-family: serif; font-size: large;">categoria </label>
								<select name="categoria" class="campoDeInput">
									<option value="all">-- todas --</option>
									<c:forEach items="${categorias}" var="categoria">
										<option value="${categoria.nome}">${categoria.nome}</option>									
									</c:forEach>									
								</select></td>
								<td width="200" align="right"><a
									href="javascript:enviar_formularioProduto()"> <img
									src="siteImagens/btbuscar.png"></img></a></td>
							</tr>
						</table>
						</form>
						</fieldset>

						<br />

						<c:if test="${not empty buscaPessoaSemParametro}">
							<div align="center"><br />
							<label
								style="color: #CD0000; font-size: small; font-weight: bold">
							digite o nome que deseja buscar ! </label></div>
						</c:if> <br />
						<fieldset><legend
							style="color: #4F4F4F; font-family: serif; font-size: large">
						Fa&ccedil;a sua busca por pessoas</legend>
						<form action="BuscaServlet" method="post" name="cadBuscaPessoa">
						<table width="400" background="siteImagens/inputpessoa.png">
							<tr>
								<td>
								<div align="left"><input type="text" name="pessoa" class="campoDeInput"	size="43"></div>
								<input type="hidden" name="optPessoa" value="true">
								<input type="hidden" name="optProduto" value="false"></td>
							</tr>
						</table>
						<br />
						<a href="javascript:enviar_formularioPessoa()"> <img
							src="siteImagens/btbuscar.png"></img></a></form>
						</fieldset>
						</div>

						<c:choose>
							<c:when test="${not empty buscaProdutoSemSucesso}">
								<div align="center"><label
									style="color: #4876FF; font-family: serif; font-size: large">
								<br />
								N&atilde;o houve resultado para a busca <i>${parametro}</i>
								solicitada !</label></div>
							</c:when>
							<c:when test="${not empty buscaProdutoComSucesso}">
								<table width="500" cellpadding="5">
									<tr>
										<td><label
											style="color: #4F4F4F; font-family: serif; font-size: large">
										Resultado: ${buscaProdutoComSucesso} ocorr&ecirc;ncia para (<i>${parametro}</i>)
										!</label></td>
									</tr>
									<c:forEach items="${produtosDaBusca}" var="produto">
										<tr>
											<td rowspan="3" bgcolor="#4F4F4F" width="93"><a
												href="VisualizarProdutoServlet?id=${produto.idproduto}">
											<img width="90" height="90" alt="clique para visualizar"
												title="clique para visualizar"
												src="CarregarImagemServlet?id=${produto.fotoPrincipal}" /></a>
											</td>
											<td><label
												style="color: #4F4F4F; font-family: serif; font-size: x-large;">
											${produto.nome}</label></td>
										</tr>
										<tr>
											<td><label
												style="color: #483D8B; font-family: serif; font-size: large;">
											${produto.descricao}</label></td>
										</tr>
										<tr>
											<td><label
												style="color: #8B4513; font-family: serif; font-size: larger">
											${produto.preco}</label></td>
										</tr>
									</c:forEach>
								</table>
							</c:when>
							<c:when test="${not empty buscaPessoaSemSucesso}">
								<div align="center"><label
									style="color: #4876FF; font-family: serif; font-size: large">
								<br />
								N&atilde;o houve resultado para a busca <i>${parametro}</i>
								solicitada !</label></div>
							</c:when>
							<c:when test="${not empty buscaPessoaComSucesso}">
								<table width="500" cellpadding="5">
									<tr>
										<td><label
											style="color: #4F4F4F; font-family: serif; font-size: large">
										Resultado: ${buscaPessoaComSucesso} ocorr&ecirc;ncia para (<i>${parametro}</i>)
										!</label></td>
									</tr>
									<c:forEach items="${clientesDaBusca}" var="cliente">
										<tr>
											<td rowspan="3" bgcolor="#4F4F4F" width="93"><a
												href="VisualizarClienteServlet?id=${cliente.idcliente}">
											<img width="90" height="90" alt="clique para visualizar"
												title="clique para visualizar"
												src="CarregarImagemServlet?id=${cliente.urlImagem}" /></a></td>
											<td><label
												style="color: #4F4F4F; font-family: serif; font-size: x-large;">
											${cliente.nome}</label></td>
										</tr>
										<tr>
											<td><label
												style="color: #483D8B; font-family: serif; font-size: large;">
											${cliente.cidade} - ${cliente.estado}</label></td>
										</tr>
										<tr>
											<td><label
												style="color: #8B4513; font-family: serif; font-size: medium">
											${cliente.nome} possui ${cliente.totalDeProdutos} produto(s)
											cadastrado(s)</label></td>
										</tr>
									</c:forEach>
								</table>
							</c:when>
						</c:choose>
						</td>
					</tr>
				</table>
				</td>
				
				<c:if test="${not empty produtoAlterado}">
					<div align="center" class="dadosAlterados"><br/>Altera&ccedil;&atilde;o realizada com Sucesso !</div>
				</c:if>

				<td valign="top" bgcolor="#E8E8E8">
					<c:choose>
					<c:when test="${empty cliente.produtos}">
						<table width="500" cellpadding="5">
							<tr>
								<td>
								<div align="center"><label
									style="color: #4F4F4F; font-family: serif; font-size: large">
								<br />
								Voc&ecirc; n&atilde;o cadastrou nenhum produto ainda !</label></div>
								</td>
							</tr>
						</table>

					</c:when>
					<c:otherwise>
						<table width="500" cellpadding="5">
							<tr>
								<td>
								<div align="center"><label
									style="color: #4F4F4F; font-family: serif; font-size: xx-large">
								Seu(s) produto(s) !</label></div>
								</td>
							</tr>
						</table>

						
							<c:forEach items="${cliente.produtos}" var="produto">
							<table width="500" cellpadding="5" >
								<tr>
									<td width="45" rowspan="3" bgcolor="#4F4F4F"><a
										href="VisualizarProdutoServlet?id=${produto.idproduto}"> <img
										width="90" height="90"
										src="CarregarImagemServlet?id=${produto.fotoPrincipal}" /></a></td>
									<td width="600">
									<label style="color: #4F4F4F; font-family: serif; font-size: x-large;">
									${produto.nome}</label></td>
									<td width="300" align="right"><a
										href="DeletarProdutoServlet?idproduto=${produto.idproduto}&idcliente=${cliente.idcliente}"
										onclick="javascript: return confirm('Deletar este produto. Deseja Prosseguir ?');"
>
									<img src="siteImagens/iconedeletar.gif"
										alt="Deletar este Produto !" title="Deletar este Produto !"></a>
									</td>
								</tr>
								<tr>
									<td><label
										style="color: #483D8B; font-family: serif; font-size: large;">
									${produto.descricao}</label></td>
									<td align="right"><a
										href="AlterarProdutoServlet?busca=true&idproduto=${produto.idproduto}&idcliente=${cliente.idcliente}">
									<img src="siteImagens/iconealterar.gif"
										alt="Editar este Produto !" title="Editar este Produto !"></a>
									</td>
								</tr>
								<tr>
									<td><label
										style="color: #8B4513; font-family: serif; font-size: larger">
									${produto.preco}</label></td>
									<td>
									<table width="100%" cellpadding="5">
										<tr><td align="right">
										<label style="color: #4F4F4F; font-family: serif; font-size: small;">
										${produto.categoria.nome}</label></td></tr>
									</table>
									</td>
								</tr>
								</table>
								<hr width="500" />								
							</c:forEach>
						
					</c:otherwise>
				</c:choose>
		</table>
		</div>
		</td>
	</tr>
</table>
</div>
<br />
<table width="100%" bgcolor="#828282" class="colapsed" cellpadding="3">
	<tr>
		<td>
		<div align="center"><img
			alt="rodape. 2011 compra e venda .com .br !"
			src="siteImagens/rodape.jpg" /></div>
		</td>
	</tr>
</table>
</body>
</html>
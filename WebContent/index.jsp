<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Compre e venda Web Site</title>
<script language="Javascript">
</script>
<style type="text/css">
#semBorda{
border: none;
}

a {
color: white;
text-decoration: none;
font-weight: bold;
}
a:HOVER{
color: #D3D3D3;
font-weight: bold;
text-decoration: none;
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
</style>
</head>
<body>

<c:if test="${empty produtos}">
	<c:if test="${empty primeiraExecucao}">
		<c:redirect url="ListaProdutosServlet?listaTodos=true"></c:redirect>
	</c:if>	
</c:if>

<div align="center">
<table width="100%" bgcolor="#828282" class="colapsed" cellpadding="10">
		<tr>
		<td>
			<div align="center"><img src="siteImagens/headerSite.jpg"></div>
		</td>
		</tr>
			
		<tr>
		<td>			
			<div align="right">
			<form action="LoginServlet" name="login" method="post">
				<c:if test="${not empty msgErroLogin}">
					<label class="erro">${msgErroLogin}</label>
				</c:if>				
				<label class="login">usu&aacute;rio </label><input type="text" name="usuario" />
				<label class="login">senha </label><input type="password" name="senha" />
				<input type="submit" value="login"><br/>			
			</form>
			</div>
		</td>
		</tr>		
</table>

</div>
<br/>
<div align="center">
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
			
		<td align="right">
		<a href="cadastrarCliente.jsp">		
		<img src="siteImagens/btcadastrar1.png" alt="Click e cadastre-se!" title="Click e cadastre-se!"></a>
		
		<a href="recuperarSenha.jsp">
		<img src="siteImagens/btrecuperarsenha1.png" alt="Esqueçeu? Então clique!" title="Esqueçeu? Então clique!"></a>				
		</td>
	</tr>
	</table>
</div>
<br/>
	
<div align="center" >
<table cellpadding="10">
	<tr>
		<td>
		<div align="center"><label style="color: #4F4F4F; font-family: serif; font-size: xx-large">
		Ultimas Atualiza&ccedil;&otilde;es !</label></div>
				
<c:forEach items="${produtos}" var="produto">
<hr align="center" width="1000" />
		
<table width="1000">
  <tr>
    <td width="101" rowspan="3" bgcolor="#4F4F4F">
    <div align="center">    
    <img width="90" height="90" src="CarregarImagemServlet?id=${produto.fotoPrincipal}" />      
    </div>
    </td>
    <td width="704"><label style="color: #4F4F4F; font-family: serif; font-size: x-large;">${produto.nome}</label></td>
    <td width="179" align="right"><img width="45" height="45" src="CarregarImagemServlet?id=${produto.cliente.urlImagem}" /></td>
  </tr>
  <tr>
    <td><label style="color: #483D8B; font-family: serif; font-size: large;">${produto.descricao}</label></td>
    <td width="179" align="right"><label style="color: #4F4F4F; font-family: serif; font-size: large;">${produto.cliente.nome}</label></td>
  </tr>
  <tr>
    <td><label style="color: #8B4513; font-family: serif; font-size: larger">${produto.preco}</label></td>
    <td align="right"><label style="color: #4F4F4F; font-family: serif; font-size: large;">${produto.dataFormatada}</label></td>
  </tr>
</table>     		
</c:forEach>				
</td>
</tr>
</table></div>

<br/>
<div align="center"><label style="color: #4F4F4F; font-family: serif; font-size: xx-large">
		<br/>Para ver mais fa&ccedil;a o seu login, ou cadastre-se no site !</label></div>

<br/>		
<table width="100%" bgcolor="#828282" class="colapsed" cellpadding="3">
	<tr>
		<td>
			<div align="center">
			<br/>
			<img alt="rodape. 2011 compra e venda .com .br !" src="siteImagens/rodape.jpg" /></div>
			<br/>
			<div align="center">
			<label style="color: white;">
				<a href="#">A empresa</a>  |  
				<a href="#">Fale Conosco</a>  |  
				<a href="#">Termo De Uso</a>  |  
				<a href="#">Pol&iacute;tica de Qualidade</a>				
			</label>
			</div>
			<br/>
		</td>
	</tr>
</table>

<div align="right">
<a href="loginAdministrador.jsp">
<label style="color: #4F4F4F; font-family: serif; font-size: smaller">manager area</label>
</a>
</div>
</body>
</html>
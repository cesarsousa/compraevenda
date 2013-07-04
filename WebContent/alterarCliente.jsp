<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Compre e Venda - Cadastro de Cliente</title>
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
</style>
</head>
<body>
<form action="AlterarClienteServlet" method="post" name="cadAlterCliente" enctype="multipart/form-data">
<div align="center">
<table width="100%">
	<tr>
		<td>
		<table width="100%" bgcolor="#828282" class="colapsed" cellpadding="3">
			<tr>
				<td>
				<div align="center">
				<img alt="Cadastro de Cliente" src="siteImagens/headerAlterDados.jpg"></div>
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
								Para alterar uma Informa&ccedil;&atilde;o de seu perfil, 
								digite o novo valor no espa&ccedil;o ao lado do campo que deseja modificar !
								
							</label>										
					</td>					
				</tr>
				<tr>
					<td width="500" align="right">
					<label class="labelDeInput"><b>${cliente.nome}</b> </label></td>
					<td width="500" align="left">
					<input type="text" name="nome" value="${nome}" class="campoDeInput" size="50"/></td>
				</tr>
				
				<tr>
					<td colspan="2" width="1000" align="center">
					<label class="labelDeInput">${cliente.email} </label></td> 
				</tr>			
				
				<tr>
					<td width="500" align="right">
					<label class="labelDeInput"><b>${cliente.cidade}</b> </label></td> 
					<td width="500" align="left">
					<input type="text" name="cidade" value="${cidade}" class="campoDeInput" size="50"/>
				</tr>
				<tr>
					<td width="500" align="right">
					<label class="labelDeInput"><b>${cliente.estado}</b> </label></td> 
					<td width="500" align="left">				
					<select name="estado" >
							<option value="${cliente.estado}">${cliente.estado}</option>
                  			<option value="AC">AC</option><option value="AL">AL</option><option value="AP">AP</option>
							<option value="AM">AM</option><option value="BA">BA</option><option value="CE">CE</option>
							<option value="DF">DF</option><option value="ES">ES</option><option value="GO">GO</option>
							<option value="MA">MA</option><option value="MT">MT</option><option value="MS">MS</option>
							<option value="MG">MG</option><option value="PA">PA</option><option value="PB">PB</option>
							<option value="PR">PR</option><option value="PE">PE</option><option value="PI">PI</option>
							<option value="RN">RN</option><option value="RS">RS</option><option value="RJ">RJ</option>
							<option value="RO">RO</option><option value="RR">RR</option><option value="SC">SC</option>
							<option value="SP">SP</option><option value="SE">SE</option><option value="TO">TO</option>
             			</select>
					</td>
				</tr>
				
				<tr>
					<td colspan="2" width="1000" align="center">
					<label class="labelDeInput">usu&aacute;rio: ${cliente.usuario}</label></td> 
				</tr>
				
				<c:if test="${not empty msgSenha}">
				<tr>
					<td colspan="2" width="1000" align="center">						
						<label style="color: #CD0000; font-size: small; font-weight: bold">
							senhas n&atilde;o conferem !
						</label>									
					</td>
				</tr>
				</c:if>
				
				<tr>
					<td width="500" align="right">
					<label class="labelDeInput">nova senha </label></td> 
					<td width="500" align="left">
					<input type="password" name="senha" value="${senha}" class="campoDeInput" size="50"/></td>
				</tr>
				<tr>
					<td width="500" align="right">
					<label class="labelDeInput">confirme a nova senha </label></td> 
					<td width="500" align="left">
					<input type="password" name="senha2" value="${senha2}" class="campoDeInput" size="50"/></td>
				</tr>
				</table>
				</div>
				
				<hr align="center" width="900" />
				
				<table width="1000" align="center">									
				<tr>				
					<td colspan="2" width="1000" align="center">
						<label style="color: #1C1C1C; font-size: large; font-weight: bold">						
						Sempre que um novo produto for ofertado no site, Deseja receber uma 
						notifica&ccedil;&atilde;o por email ? 
						</label>				
					</td>
				</tr>
				<tr>
					<td colspan="2" width="1000" align="center">
					<input type="radio" name="notificacao" value="true" checked="checked"/>
					<label class="labelDeInput">Sim, desejo receber notifica&ccedil;&atilde;o por email.</label></td>
				</tr>
				<tr>
					<td colspan="2" width="1000" align="center">
					<input type="radio" name="notificacao" value="false" />
					<label class="labelDeInput">N&atilde;o, obrigado.</label></td>
				</tr>							
			</table>
			
			<hr align="center" width="900" />
			
			<table width="1000" align="center" bgcolor="#F0FFFF">
				<tr>
					<td colspan="2" width="1000" align="center">
						<label style="color: #3A5FCD; font-size: medium;">
						Informa&ccedil;&otilde;es adicionais sobre seu perfil !
						</label>				
					</td>
				</tr>
				<tr>
					<td width="500" align="right">
					<label class="labelDeInput"><i>(telefone)</i> <b>${cliente.telefone}</b> </label></td> 
					<td width="500" align="left">
					<input type="text" name="telefone" value="${telefone}" class="campoDeInput" size="50"/></td>
				</tr>
				<tr>
					<td width="500" align="right">
					<label class="labelDeInput"><i>Desejo que meu telefone seja removido de meu cadastro</i></label></td> 
					<td width="500" align="left">
					<input type="checkbox" name="removerTelefone" value="true" /></td>
				</tr>
				<tr>
					<td width="500" align="right">
					<label class="labelDeInput"><i>Desejo que meu telefone fique v&iacute;sivel em meu perfil</i></label></td> 
					<td width="500" align="left">
					<input type="radio" name="autorizarTelefone" value="true" /></td>
				</tr>
				<tr>
					<td width="500" align="right">
					<label class="labelDeInput"><i>Desejo que meu telefone <b>n&atilde;o</b> fique v&iacute;sivel em meu perfil</i></label></td> 
					<td width="500" align="left">
					<input type="radio" name="autorizarTelefone" value="false" checked="checked"/></td>
				</tr>
				<tr><td colspan="2" align="center"><hr align="center" width="500" /></td></tr>	
				<tr>
					<td width="500" align="right">
					<label class="labelDeInput"><i>(endere&ccedil;o)</i> <b>${cliente.endereco}</b> </label></td> 
					<td width="500" align="left">
					<input type="text" name="endereco" value="${endereco}" class="campoDeInput" size="50"/></td>
				</tr>
				<tr>
					<td width="500" align="right">
					<label class="labelDeInput"><i>Desejo que meu endere&ccedil;o seja removido de meu cadastro</i></label></td> 
					<td width="500" align="left">
					<input type="checkbox" name="removerEndereco" value="true" /></td>
				</tr>
				<tr>
					<td width="500" align="right">
					<label class="labelDeInput"><i>Desejo que meu endere&ccedil;o fique v&iacute;sivel em meu perfil</i></label></td> 
					<td width="500" align="left">
					<input type="radio" name="autorizarEndereco" value="true" /></td>
				</tr>				
				<tr>
					<td width="500" align="right">
					<label class="labelDeInput"><i>Desejo que meu endere&ccedil;o <b>n&atilde;o</b> fique v&iacute;sivel em meu perfil</i></label></td> 
					<td width="500" align="left">
					<input type="radio" name="autorizarEndereco" value="false" checked="checked"/></td>
				</tr>
			</table>
			
			<hr>
			
			<hr align="center" width="500" >
			<table align="center" bgcolor="#F0FFFF">				
				<tr>
					<td width="500" align="right">
					<label class="labelDeInput"><i>(orkut)</i> <b>${cliente.redeSocial.orkut}</b> </label></td> 
					<td width="500" align="left">
					<input type="text" name="orkut" value="${orkut}" class="campoDeInput" size="50"/></td>
				</tr>			
				<tr>
					<td width="500" align="right">
					<label class="labelDeInput"><i>Desejo que meu orkut seja removido de meu cadastro</i></label></td> 
					<td width="500" align="left">
					<input type="checkbox" name="removerOrkut" value="true" /></td>
				</tr>
			</table>
			<hr align="center" width="500" />
			<table align="center" bgcolor="#F0FFFF">			
				<tr>
					<td width="500" align="right">
					<label class="labelDeInput"><i>(facebook)</i> <b>${cliente.redeSocial.facebook}</b> </label></td> 
					<td width="500" align="left">
					<input type="text" name="facebook" value="${facebook}" class="campoDeInput" size="50"/></td>
				</tr>
				<tr>
					<td width="500" align="right">
					<label class="labelDeInput"><i>Desejo que meu facebook seja removido de meu cadastro</i></label></td> 
					<td width="500" align="left">
					<input type="checkbox" name="removerFacebook" value="true" /></td>
				</tr>
			</table>
			<hr align="center" width="500" />
			<table align="center" bgcolor="#F0FFFF">				
				<tr>
					<td width="500" align="right">
					<label class="labelDeInput"><i>(twitter)</i> <b>${cliente.redeSocial.twitter}</b> </label></td> 
					<td width="500" align="left">
					<input type="text" name="twitter" value="${twitter}" class="campoDeInput" size="50"/></td>
				</tr>
				<tr>
					<td width="500" align="right">
					<label class="labelDeInput"><i>Desejo que meu twitter seja removido de meu cadastro</i></label></td> 
					<td width="500" align="left">
					<input type="checkbox" name="removerTwitter" value="true" /></td>
				</tr>
			</table>
			
			
			<hr align="center" width="900" />
			
			<table width="1000" align="center" bgcolor="#F0FFFF">				
				<tr>
					<td colspan="2" width="1000" align="center">
						<c:if test="${not empty msgFoto}">
							<label style="color: #3A5FCD; font-size: small; font-weight: bold">
								arquivo deve ser uma foto .jpg ou .png !
							</label>
						</c:if>
					</td>
				</tr>
				<tr>
					<td width="500" align="right">
					<img width="80" height="100" alt="${cliente.nome}"
					src="CarregarImagemServlet?id=${cliente.urlImagem}" />
					</td>				
				</tr>
				<tr>
					<td width="500" align="right">
					<label class="labelDeInput">alterar foto ?</label></td> 
					<td width="500" align="left">
					<input type="file" name="imagem"/></td>
				</tr>
				<c:if test="${cliente.foto}">					
				<tr>					
					<td width="500" align="right">
					<label class="labelDeInput">Remover esta foto ?</label></td>
					<td width="500" align="left">					
					<input type="checkbox" name="removerFoto" value="true"/>					
					</td>
				</tr>				
				</c:if>
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
		<a href="DeletarClienteServlet" 
		   onclick="javascript:return confirm('Você esta prestes a deletar o seu perfil de nosso sistema, esta ação não poderá ser desfeita. Deseja Prosseguir ?')">
		<img src="siteImagens/btdelperfil.png" alt="Apagar meu Perfil !" title="Apagar meu Perfil !"></a>
		
		<a href="#" onclick="document.cadAlterCliente.submit();">		
		<img src="siteImagens/btsalvar.png" alt="Salvar alterações !" title="Salvar alterações !"></a></td>
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
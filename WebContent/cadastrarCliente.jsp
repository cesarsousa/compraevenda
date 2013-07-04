<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
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
font-weight: bold;
}
.labelDeInput2 {
color: #363636; 
font-size: large;
}
</style>
</head>
<body>
<form action="CadastrarClienteServlet" method="post" name="cadCliente" enctype="multipart/form-data">
<div align="center">
<table width="100%">
	<tr>
		<td>
		<table width="100%" bgcolor="#828282" class="colapsed" cellpadding="3">
			<tr>
				<td>
				<div align="center">
				<img alt="Cadastro de Cliente" src="siteImagens/headerCadCliente.jpg"></div>
				</td>
			</tr>
		</table>
			
			<br/>
			<hr align="center" width="900" />
			<div align="center">
			<table width="1000" border="0">
				<tr>
					<td colspan="2" width="1000" align="center">
						<c:if test="${not empty msgErro}">
							<label style="color: #CD0000; font-size: small; font-weight: bold">
								Informa&ccedil;&otilde;es para contato. Preenchimento obrigatório !
							</label>
						</c:if>
						<c:if test="${empty msgErro}">											
							<label style="color: #FF7256; font-size: small">
								Informa&ccedil;&otilde;es para contato. Preenchimento obrigatório !
							</label>
						</c:if>						
					</td>					
				</tr>
				<tr>
					<td width="500" align="right">
					<label class="labelDeInput">nome </label></td>
					<td width="500" align="left">
					<input type="text" name="nome" value="${nome}" class="campoDeInput" size="50"/></td>
				</tr>
				
				<c:if test="${not empty msgEmailIndisponivel}">
				<tr>
					<td colspan="2" width="1000" align="center">
							<label style="color: #CD0000; font-size: small; font-weight: bold">
								O e-mail (<i>${email}</i>) j&aacute; est&aacute; em uso, digite outro e-mail !<br/>
							</label>
					</td>
				</tr>
				</c:if>
				
				<tr>
					<td width="500" align="right">					
					<label class="labelDeInput">e-mail </label></td> 
					<td width="500" align="left">
					<input type="text" name="email" value="${email}" class="campoDeInput" size="50"/></td>
				</tr>
				<tr>
					<td width="500" align="right">
					<label class="labelDeInput">cidade </label></td> 
					<td width="500" align="left">
					<input type="text" name="cidade" value="${cidade}" class="campoDeInput" size="50"/>
				</tr>
				<tr>
					<td width="500" align="right">					
					<label class="labelDeInput">estado </label></td> 
					<td width="500" align="left">					
					<select name="estado">							
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
						<c:if test="${not empty msgLogin}">
							<label style="color: #CD0000; font-size: small; font-weight: bold">
								Informa&ccedil;&otilde;es de acesso ao sistema. Preenchimento obrigat&oacute;rio !
							</label>
						</c:if>	
						<c:if test="${empty msgLogin}">
							<label style="color: #FF7256; font-size: small">
								Informa&ccedil;&otilde;es de acesso ao sistema. Preenchimento obrigat&oacute;rio !
							</label>
						</c:if>						
						<c:if test="${not empty msgUsuario}">
							<label style="color: #CD0000; font-size: small; font-weight: bold">
								<br/>o nome de usu&aacute;rio <i>${usuario}</i> n&atilde;o esta dispon&iacute;vel !
							</label>
						</c:if>			
					</td>
				</tr>
				<tr>
					<td width="500" align="right">
					<label class="labelDeInput">usu&aacute;rio </label></td> 
					<td width="500" align="left">
					<input type="text" name="usuario" value="${usuario}" class="campoDeInput" size="50"/></td>
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
					<label class="labelDeInput">senha </label></td> 
					<td width="500" align="left">
					<input type="password" name="senha" value="${senha}" class="campoDeInput" size="50"/></td>
				</tr>
				<tr>
					<td width="500" align="right">
					<label class="labelDeInput">confirme sua senha </label></td> 
					<td width="500" align="left">
					<input type="password" name="senha2" value="${senha2}" class="campoDeInput" size="50"/></td>
				</tr>
				</table>
				</div>
				
				<hr align="center" width="900" />
				
				<table width="1000" align="center">								
				<tr>				
					<td colspan="2" width="1000" align="center">
						<label style="color: #1C1C1C; font-size: large;">						
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
						<label style="color: #3A5FCD; font-size: large;">
						Informa&ccedil;&otilde;es adicionais sobre seu perfil. Preenchimento opcional !
						</label>				
					</td>
				</tr>
				<tr>
					<td width="500" align="right">
					<label class="labelDeInput">telefone </label></td> 
					<td width="500" align="left">
					<input type="text" name="telefone" value="${telefone}" class="campoDeInput" size="50"/></td>
				</tr>
				<tr>
					<td width="500" align="right">
					<input type="radio" name="autorizarTelefone" value="true" /></td>
					<td width="500" align="left">
					<label class="labelDeInput2">Autorizo que meu telefone seja divulgado em meu perfil ! </label></td>					
				</tr>
				<tr>
					<td width="500" align="right">
					<input type="radio" name="autorizarTelefone" value="false" checked="checked"/></td>
					<td width="500" align="left">
					<label class="labelDeInput2">N&atilde;o, quero manter meu telefone protegido ! </label></td>					
				</tr>				
				<tr>
					<td width="500" align="right">
					<label class="labelDeInput">endere&ccedil;o </label></td> 
					<td width="500" align="left">
					<input type="text" name="endereco" value="${endereco}" class="campoDeInput" size="50"/></td>
				</tr>
				<tr>
					<td width="500" align="right">
					<input type="radio" name="autorizarEndereco" value="true" /></td>
					<td width="500" align="left">
					<label class="labelDeInput2">Autorizo que meu endere&ccedil;o seja divulgado em meu perfil ! </label></td>					
				</tr>
				<tr>
					<td width="500" align="right">
					<input type="radio" name="autorizarEndereco" value="false" checked="checked" /></td>
					<td width="500" align="left">
					<label class="labelDeInput2">N&atilde;o, quero manter meu endere&ccedil;o protegido ! </label></td> 					
				</tr>
				<tr>
					<td colspan="2" width="1000" align="center">
						<label style="color: #3A5FCD; font-size: large;">
						Adicione suas redes sociais em seu perfil, se preferir !
						</label>				
					</td>
				</tr>
				<tr>
					<td width="500" align="right">
					<label class="labelDeInput">orkut </label></td>
					<td width="500" align="left">
					<input type="text" name="orkut" value="${orkut}" class="campoDeInput" size="50"/></td>				
				</tr>
				<tr>
					<td width="500" align="right">
					<label class="labelDeInput">facebook </label></td>
					<td width="500" align="left">
					<input type="text" name="facebook" value="${facebook}" class="campoDeInput" size="50"/></td>				
				</tr>
				<tr>
					<td width="500" align="right">
					<label class="labelDeInput">twitter </label></td>
					<td width="500" align="left">
					<input type="text" name="twitter" value="${twitter}" class="campoDeInput" size="50"/></td>				
				</tr>
				<tr>
					<td colspan="2" width="1000" align="center">
						<c:if test="${not empty msgFoto}">
							<label style="color: #3A5FCD; font-size: small; font-weight: bold">
								arquivo deve ser uma foto .jpg ou .png !
							</label>
						</c:if>
					</td>
				</tr>
				</table>
				
				<hr align="center" width="900" />
				
				<table width="1000" align="center" bgcolor="#F0FFFF">
				<tr>
					<td width="1000" align="center">
					<img alt="Escolha sua foto !" title="Escolha sua foto !" 
					src="imagem/fotoDefault.jpg" width="50" height="60" /><br/>
					<label class="labelDeInput">selecione sua foto</label><br/>					
					<input type="file" name="imagem"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<hr align="center" width="900" />

<table width="100%" bgcolor="#E8E8E8" cellpadding="5"><tr><td>
<div align="center">
<pre>
<textarea rows="10" cols="100">
TERMO DE SERVIÇOS E CONTRATO.

Bem-vindo ao Portal Compre e Venda de Tudo!

1. Relação do usuário com o site.

    1.1 O uso dos serviços está sujeito aos termos de um contrato entre o usuário e o Portal. 'Portal' significa compreevendadetudo.com.

2. Aceitação dos Termos

    2.1 Para usar os Serviços, o usuário deverá primeiro concordar com os Termos. Não é permitido o uso dos Serviços por parte do usuário se ele não aceitar os Termos.

    2.2 O usuário pode aceitar os Termos:

        (A) clicando para aceitar ou concordar com os Termos

    2.3 Antes de continuar, o usuário deverá imprimir ou guardar uma cópia local dos Termos Universais em seus registros.


3. Prestação dos Serviços pelo Google

    3.1 O Protal está constantemente inovando para poder oferecer a melhor experiência possível aos seus usuários. O usuário tem conhecimento e aceita que a forma e natureza dos Serviços fornecidos pelo Portal podem mudar ocasionalmente sem aviso prévio ao usuário.

    3.2 Como parte dessa constante inovação, o usuário tem conhecimento e concorda que o Portal pode, a seu próprio critério, deixar (permanente ou temporariamente) de fornecer os Serviços (ou qualquer funcionalidade dos Serviços) aos usuários em geral, sem aviso prévio. O usuário pode deixar de utilizar os Serviços a qualquer momento. O usuário não necessita informar especificamente o Potal quando deixar de usar os Serviços.

    3.3 O usuário reconhece e aceita que, se o Portal desativar a sua conta, poderá ser impedido de acessar os Serviços, os detalhes da conta ou quaisquer arquivos ou outros conteúdos que estejam na conta.

    3.4 O usuário reconhece e concorda que, apesar de o Portal atualmente não fixar um limite máximo quanto ao número de transmissões que é possível enviar ou receber através dos Serviços ou quanto ao espaço de armazenamento utilizado para a prestação de qualquer Serviço, o mesmo poderá, segundo critérios próprios e a qualquer momento, fixar esses limites máximos.

4. Uso dos Serviços por parte do usuário

    4.1 Para acessar os Serviços, poderá ser solicitado ao usuário que forneça informações pessoais (tais como usuário e senha) como parte do processo de registro para o Serviço ou como parte da utilização continuada dos Serviços por parte do usuário. O usuário concorda que as informações de registro que fornecer ao Portal serão sempre exatas, corretas e atualizadas.

    4.2 O usuário concorda em usar os Serviços somente para os fins permitidos: (a) pelos Termos; e (b) quaisquer leis, regulamentos ou práticas ou diretrizes geralmente aceitas nas jurisdições relevantes (inclusive todas as leis em relação à exportação de dados ou software ).

    4.3 O usuário concorda em não acessar (nem tentar acessar) qualquer um dos Serviços por qualquer meio que não seja através da interface fornecida pelo Portal, exceto se for especificamente autorizado a tal em um contrato em separado firmado com o Portal.O usuário concorda especificamente em não acessar (nem tentar acessar) qualquer um dos Serviços por meio de meios automatizados (inclusive uso de scripts ou rastreadores da web), bem como deverá garantir que esteja em conformidade com as instruções definidas em todos os arquivos robots.txt apresentados nos Serviços.

    4.4 O usuário concorda em não participar de nenhuma atividade que interfira ou interrompa o funcionamento dos Serviços (ou servidores e redes conectados aos Serviços).

    4.5 Exceto se tiver sido especificamente autorizado por meio de um contrato em separado firmado com o Portal, o usuário concorda em não reproduzir, duplicar, copiar, vender, comercializar ou revender os Serviços para qualquer efeito.

    4.6 O usuário concorda que será o único responsável (e que o Portal não tem qualquer responsabilidade perante o usuário ou terceiros) por qualquer não cumprimento das suas obrigações no que diz respeito aos Termos e pelas conseqüências (incluindo qualquer perda ou dano que o Portal possa sofrer) resultantes desse não cumprimento.

5. Segurança da conta e senhas do usuário

    5.1 O usuário concorda e compreende que será responsável por manter a confidencialidade das senhas associadas a qualquer conta que utilize para acessar os Serviços.

    5.2 Dessa forma, o usuário concorda que será o único responsável perante o Potal por todas as atividades que ocorram na respectiva conta.

    5.3 Se tomar conhecimento de qualquer utilização não autorizada da sua senha ou da sua conta, o usuário concorda em notificar imediatamente o Portal no canal de fale conosco da aplicação.

6. Informações pessoais do usuário

    6.1 O usuário concorda com a utilização de seus dados pelo Portal.

7. Conteúdo nos Serviços

    7.1 O usuário compreende que a responsabilidade integral por todas as informações (tais como arquivos de dados, texto escrito, fotografias) a que possa ter acesso como parte dos Serviços, ou através da utilização dos mesmos, é da pessoa que deu origem a esse conteúdo. Todas essas informações são denominadas “Conteúdo”.

    7.2 O usuário deverá estar ciente de que o Conteúdo que lhe é apresentado como parte dos Serviços, pode estar protegido por direitos de propriedade intelectual que são de propriedade dos anunciantes que fornecem esse Conteúdo ao Portal. O usuário não poderá efetuar modificação, aluguel, arrendamento, empréstimo, venda, distribuição ou criação de obras derivadas baseadas neste Conteúdo (no todo ou em parte), a menos que tenha sido especificamente autorizado a fazê-lo, através de um contrato em separado, pelo Portal ou pelos proprietários desse Conteúdo.

    7.3 O Portal se reserva o direito (mas não tem qualquer obrigação) de pré-selecionar, rever, marcar, filtrar, modificar, recusar ou remover qualquer ou todo Conteúdo de qualquer Serviço. O Portal irá remover qualquer conteúdos sexuais explícitos, racista ou pejorativo, que possa considerar ofensivo.

    7.4 O usuário compreende que, ao utilizar os Serviços, pode estar exposto a Conteúdo que possa considerar ofensivo, indecente ou censurável e que, a este respeito, utiliza os Serviços por sua conta e risco.

    7.5 O usuário concorda que será o único responsável (e que o Portal não tem qualquer responsabilidade perante o usuário ou terceiros) por qualquer Conteúdo que crie, transmita ou visualize enquanto utiliza os Serviços e pelas conseqüências das suas ações (incluindo qualquer perda ou dano que o Portal possa sofrer) resultantes disso.

8. Direitos de propriedade

    8.1 O usuário reconhece e concorda que o Portal detém todos os direitos legais, títulos e participações relativas aos Serviços, incluindo quaisquer direitos de propriedade intelectual que subsistam nos Serviços (quer esses direitos estejam registrados ou não, e em qualquer parte do mundo onde esses direitos possam existir). Além disso, o usuário reconhece que os Serviços podem conter informações designadas confidenciais pelo Potal e que não as revelará sem o prévio consentimento escrito do Portal.

    8.2 A menos que o usuário tenha concordado por escrito em contrário com o Portal, nada nos Termos lhe dá o direito de utilizar qualquer uma das marcas registradas, marcas comerciais, marcas de serviços, logotipos, nomes de domínios e outras características de marca especiais do Portal.

    8.3 O usuário concorda que não removerá, ocultará nem alterará quaisquer avisos de direitos de propriedade (incluindo avisos de direitos de autor e de marcas comerciais) que possam estar afixados ou contidos nos Serviços.

    8.4 A menos que tenha sido expressamente autorizado por escrito pelo Portal a fazê-lo, o usuário concorda que, ao usar os Serviços, não irá utilizar qualquer marca comercial, marca de serviço, marca registrada, logotipo de qualquer empresa ou organização de forma que seja provável ou pretendido que cause confusão relativamente ao proprietário ou usuário autorizado dessas marcas, nomes ou logotipos.

9. Licença de conteúdo do usuário

    9.1 O usuário retém direitos autorais e quaisquer outros direitos que já tiver posse em relação ao Conteúdo que enviar, publicar ou exibir nos Serviços ou através deles. Ao enviar, publicar ou exibir conteúdo, o usuário concede ao Google uma licença irrevogável, perpétua, mundial, isenta de royalties e não exclusiva de reproduzir, adaptar, modificar, traduzir, publicar, distribuir publicamente, exibir publicamente e distribuir qualquer Conteúdo que o usuário enviar, publicar ou exibir nos Serviços ou através deles. Essa licença tem como único objetivo permitir ao Google apresentar, distribuir e promover os Serviços e pode ser revogada para certos Serviços, conforme definido nos Termos Adicionais desses Serviços.

    9.2 O usuário concorda que essa licença inclui o direito do Portal de disponibilizar esse Conteúdo a outras empresas, organizações ou indivíduos com quem o Portal tenha relações para o fornecimento de serviços licenciados e para o uso desse Conteúdo relacionado ao fornecimento desses serviços.

    9.3 O usuário confirma e garante ao Portal que tem todos os direitos, poderes e autoridade necessários para outorgar a licença citada anteriormente.

10. Término da relação do usuário com o Poratl

    10.1 Os Termos continuarão a ser aplicáveis até serem encerrados pelo usuário ou pelo Portal, conforme estabelecido a seguir.

    10.2 Se o usuário quiser encerrar o seu contrato com o Portal, pode fazê-lo (a) notificando o Google a qualquer momento e (b) encerrando as contas relativas a todos os Serviços que utiliza, no caso de essa opção ser disponibilizada pelo Portal.

    10.3 O Portal pode, a qualquer momento, encerrar o contrato com o usuário se:

        (A) o usuário tiver violado qualquer cláusula dos Termos (ou tiver agido de forma que claramente mostre que não pretende ou não pode cumprir as cláusulas dos Termos); ou

        (B) tal for exigido ao Portal por lei (por exemplo, quando o fornecimento dos Serviços ao usuário for ou se tornar ilegal); ou        

11. Anúncios

    11.1 Alguns dos Serviços são mantidos por receita proveniente de publicidade e podem exibir anúncios e promoções. Tais anúncios podem ser contextuais ao conteúdo da informação armazenada nos Serviços, pesquisas feitas por meio dos Serviços ou outras informações.

    11.2 A maneira, modo e abrangência da publicidade do Portal nos Serviços estão sujeitos a alterações sem aviso prévio específico ao usuário.

    11.3 Considerando a concessão por parte do Portal do acesso e uso dos Serviços, o usuário manifesta o seu acordo sobre a possibilidade de o Portal colocar tais anúncios nos Serviços.

12. Outros conteúdos

    12.1 Os Serviços podem incluir hiperlinks a outros sites, conteúdo ou recursos da web. O Portal pode não ter nenhum controle sobre quaisquer sites ou recursos da web fornecidos por empresas ou pessoas que não o Portal.

    12.2 O usuário reconhece e concorda que o Portal não é responsável pela disponibilidade de qualquer um desses sites ou recursos externos e nem endossa qualquer anúncio, produto ou outro material disponível ou originado em tais sites e recursos da web.

    12.3 O usuário reconhece e concorda que o Portal não é responsável por qualquer perda ou dano em que possa incorrer em resultado da disponibilidade de tais sites ou recursos externos, ou em decorrência de qualquer expectativa esperada pelo usuário em relação à integridade, precisão ou existência de quaisquer anúncios, produtos ou outros materiais presentes ou disponíveis a partir de tais sites ou recursos da web.

13. Alterações nos Termos

    13.1 O Portal poderá alterar periodicamente os Termos Universais ou Termos Adicionais. Quando essas alterações forem efetuadas.


01 de Maio de 2011.
</textarea><br/><br/>
</pre>
<input type="radio" name="termoDoContrato" value="true" checked="checked"/>
	<label class="labelDeInput">Li e aceito os termos do contrato de utiliza&ccedil;&atilde;o do site !</label>
<br/>
<input type="radio" name="termoDoContrato" value="false" />
	<label class="labelDeInput">Li e n&atilde;o concordo, n&atilde;o quero mais me cadastrar !</label>
</div><br/>
</td></tr></table>		
			
<hr align="center" width="900" />
			
			<table>
				<tr>
					<td width="500" align="left">
						<a href="index.jsp">		
						<img src="siteImagens/btvoltar.png" alt="Voltar para HomePage!" title="Voltar para HomePage!"></a>
					</td>
					
					<td width="500" align="right">					
						<a href="#" onclick="document.cadCliente.submit();">		
						<img src="siteImagens/btcadastrar2.png" alt="Cadastrar!" title="Cadastrar!"></a>
									
						<a href="#" onclick="document.cadCliente.reset();">		
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
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Compre e Venda - Administrator</title>
<style type="text/css">
.campoDeInput{
border: 2px solid #4F4F4F;
}
.labelDeInput {
color: #363636; 
font-size: xx-large	;
font-weight: bold;
}
.erro{
font-weight: bold;
color: white;
}
</style>
</head>
<body>
<br/>
<table width="100%" bgcolor="#828282" class="colapsed" cellpadding="10">
	<tr>
		<td>
		<div align="center"><img src="siteImagens/headerManagerArea.jpg"></div>
		</td>
	</tr>
</table>
<br/>

<c:if test="${not empty msgErro}">
<table width="100%" bgcolor="#B22222">
	<tr>
		<td><div align="center"><label class="erro">Access Denied</label></div></td>
	</tr>
</table>
<br/>
</c:if>

<div align="center">
<form action="ADMServlet" method="post">
	<table width="1000" bgcolor="#E6E6FA" cellpadding="10">
		<tr>
		<td colspan="2" width="1000" align="center">
		<label class="labelDeInput">restricted area authorized personnel only<br/><br/></label></td>
		</tr>		
		<tr>
		<td width="500" align="right"><label style="color: #483D8B; font-family: serif; font-size: large;">User</label></td>
		<td width="500" align="left"><input type="text" name="user" class="campoDeInput"></input></td>
		</tr>
		
		<tr>
		<td width="500" align="right"><label style="color: #483D8B; font-family: serif; font-size: large;">Password</label></td>
		<td width="500" align="left"><input type="password" name="password" class="campoDeInput"></input></td>
		</tr>
		
		<tr>		
		<td colspan="2" width="1000" align="center"><input type="submit" value="Access"></input></td>
		</tr>
	</table>
	<br/><br/>
</form>
</div>
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
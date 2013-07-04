package br.com.compraevenda.controlador;

import java.io.IOException;

import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.internet.AddressException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.sun.mail.smtp.SMTPAddressFailedException;

import br.com.compraevenda.dao.ClienteDAO;
import br.com.compraevenda.modelo.Cliente;
import br.com.compraevenda.util.Email;

public class RecuperarSenhaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {
		
		String pagina = "/recuperarSenha.jsp";
		
		String email = request.getParameter("email");				
		Session hibernateSession = (Session)request.getAttribute("session");
		ClienteDAO dao = new ClienteDAO(hibernateSession);		
		
		if (email.isEmpty()){
			request.setAttribute("msgEmail", "O email deve ser informado!");				
		} else {
			Cliente cliente = dao.getCliente(email);
			request.setAttribute("email", email);
			if (cliente == null){					
				request.setAttribute("msgEmail", "O email informado não consta em nossa base de dados!");
			} else {
				try {					
					Email.enviarEmail(getInitParameter("email"), getInitParameter("senha"), 
							email, getAssunto(), getMensagem(cliente));
				} catch (AddressException e) {
					pagina = "/resposta.jsp";
					request.setAttribute("codigo", "AE01");
					e.printStackTrace();
				} catch (SMTPAddressFailedException e) {
					pagina = "/resposta.jsp";
					request.setAttribute("codigo", "SMTPAFE01");
					e.printStackTrace();
				} catch (NoSuchProviderException e) {
					request.setAttribute("codigo", "NSPE01");
					pagina = "/resposta.jsp";
					e.printStackTrace();
				} catch (MessagingException e) {
					request.setAttribute("codigo", "ME01");
					pagina = "/resposta.jsp";
					e.printStackTrace();
				}			
				
				request.setAttribute("msgEnviado", true);
			}
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(pagina);
		dispatcher.forward(request, response);
	}	

	private String getAssunto() {
		return "Portal Compre e Venda. Recuperação de senha.";
	}
	
	private String getMensagem(Cliente cliente) {		
		return "<table bgcolor=\"#E8E8E8\"><tr><td><div align=\"center\">Ol&aacute; <b>" + cliente.getNome()+ ",</b><br/><br/>Atendendo ao seu pedido, estamos " +
				"lhe enviando sua senha para acessar os servi&ccedil;os do <b>compraevenda.com.br</b><br/><br/>" +
				"Seu login de acesso &eacute;:<br/><p><b>usu&aacute;rio</b>: " + cliente.getUsuario() + "<br>" +
				" <b>senha</b>: " + cliente.getSenha() + "</p>" +
				"<br/><br/><br/>Para sua seguran&ccedil;a n&atilde;o revele sua senha a ningu&eacute;m." +
				" Essa mensagem foi enviada apenas para o seu e-mail, e s&oacute; voc&ecirc; tem acesso a ela." +
				"<hr width=\"100%\" size=\"2\"><br/>" +
				"<br/><p>Este email &eacute; autom&aacute;tico" +	
				", favor n&atilde;o responder esta mensagem, para entrar em contato conosco utilize" +
				" nossos canais de contato atrav&eacute;s do site.</p>" +
				"<p><a href=\"http://localhost:8080/compraevenda.com.br/index.jsp\">nosso site</a>" +
				"<br/><br/>Atenciosamente,<br/>Equipe Compra e Venda" +
				"</p></div></td></tr></table>";
	}

}

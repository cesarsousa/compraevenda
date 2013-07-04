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

import br.com.compraevenda.util.Email;

import com.sun.mail.smtp.SMTPAddressFailedException;

// TODO classe unused
public class EnviarEmailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	String email;
	String senha;
	String emailDestino;
	String assunto;
	String mensagem;
	
	public void enviar(String email, String senha, String emailDestino, String assunto, String mensagem,
			HttpServletRequest request, HttpServletResponse response){
		this.email = email;
		this.senha = senha;
		this.emailDestino = emailDestino;
		this.assunto = assunto;
		this.mensagem = mensagem;
		try {
			service(request, response);
		} catch (ServletException e) {			
			e.printStackTrace();
		} catch (IOException e) {			
			e.printStackTrace();
		}
	}
   
	protected void service(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {
		
		boolean erroDeEnvioDeEmail = false;
		
		try {					
			Email.enviarEmail(email, senha, emailDestino, assunto, mensagem);
		} catch (AddressException e) {			
			request.setAttribute("codigo", "AE01");
			erroDeEnvioDeEmail = true;
			e.printStackTrace();			
		} catch (SMTPAddressFailedException e) {			
			request.setAttribute("codigo", "SMTPAFE01");
			erroDeEnvioDeEmail = true;
			e.printStackTrace();			
		} catch (NoSuchProviderException e) {
			request.setAttribute("codigo", "NSPE01");
			erroDeEnvioDeEmail = true;
			e.printStackTrace();
		} catch (MessagingException e) {
			request.setAttribute("codigo", "ME01");
			erroDeEnvioDeEmail = true;
			e.printStackTrace();			
		}
		
		if (erroDeEnvioDeEmail) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/resposta.jsp");
			dispatcher.forward(request, response);
		}
	}
}

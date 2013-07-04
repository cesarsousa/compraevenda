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
import javax.servlet.http.HttpSession;

import org.hibernate.Session;

import com.sun.mail.smtp.SMTPAddressFailedException;

import br.com.compraevenda.dao.ClienteDAO;
import br.com.compraevenda.dao.ProdutoDAO;
import br.com.compraevenda.modelo.Cliente;
import br.com.compraevenda.modelo.Produto;
import br.com.compraevenda.util.Email;


public class EnviarMensagemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
		
	protected void service(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {
		
		HttpSession sessao = request.getSession();
		Cliente clienteSessao = (Cliente) sessao.getAttribute("cliente");
		
		Session hibernateSession = (Session)request.getAttribute("session");
		
		Produto produto = null;
		
		boolean isPerfil = Boolean.valueOf(request.getParameter("perfil"));
		boolean isProduto = Boolean.valueOf(request.getParameter("produto"));
		String mensagem = request.getParameter("mensagem");
		
		String pagina = "";	
		String emailDestino = "";
		String assunto= "";
		
		if (isPerfil){			
			int idPerfil = Integer.parseInt(request.getParameter("id"));
			ClienteDAO dao = new ClienteDAO(hibernateSession);			
			Cliente perfil = dao.getCliente(idPerfil);
			request.setAttribute("perfil", perfil);
			emailDestino = request.getParameter("email");
			assunto = "mensagem";
			pagina = "/perfil.jsp";		
		}
		
		if (isProduto){			
			int idProduto = Integer.valueOf(request.getParameter("idProduto"));
			ProdutoDAO produtoDao = new ProdutoDAO(hibernateSession);			
			produto = produtoDao.getProduto(idProduto);
			request.setAttribute("produto", produto);
			emailDestino = produto.getCliente().getEmail();
			assunto = "proposta";
			pagina = "/produto.jsp";
		}
		
		try {
			Email.enviarEmail(
					getInitParameter("email"),
					getInitParameter("senha"), 
					emailDestino, 
					getAssunto(assunto),
					getMensagem(mensagem, clienteSessao, produto));
		} catch (AddressException e) {
			pagina = "/resposta.jsp";
			request.setAttribute("codigo", "AE02");
			e.printStackTrace();
		} catch (SMTPAddressFailedException e) {
			pagina = "/resposta.jsp";
			request.setAttribute("codigo", "SMTPAFE02");
			e.printStackTrace();
		} catch (NoSuchProviderException e) {
			request.setAttribute("codigo", "NSPE02");
			pagina = "/resposta.jsp";
			e.printStackTrace();
		} catch (MessagingException e) {
			request.setAttribute("codigo", "ME02");
			pagina = "/resposta.jsp";
			e.printStackTrace();
		}
		
		request.setAttribute("emailEnviado", true);		
		RequestDispatcher dispatcher = request.getRequestDispatcher(pagina);	
		dispatcher.forward(request, response);
	}	
	
	private String getMensagem(String mensagem, Cliente cliente, Produto produto) {
		return (produto == null) ?
				"<div align=\"center\"><font size=\"5\">Portal Compre e Venda De Tudo</font><br/></div>"
				+ "Mensagem enviada por " + cliente.getNome() + ".<br/><br/>"
				+ "<p><i>"	+ mensagem + "</i></p><br/>"
				+ "<hr width=\"100%\" size=\"2\"><br/>"
				+ "<p>Este email &eacute; autom&aacute;tico, para respond&ecirc;-lo utilize " 
				+ "os servi&ccedil;os de nosso portal e entre em contato com "
				+ "<i>" + cliente.getNome() + "</i> ou clique no link abaixo e encaminhe sua resposta</p><br/>" 
				+ "<div align=\"center\">" + cliente.getEmail() + "</div>"
				+ "<p>Equipe Compre e Venda</p>"
				:
				"<div align=\"center\"><font size=\"5\">Portal Compre e Venda De Tudo</font><br/></div>"
				+ "Mensagem enviada por " + cliente.getNome() + ".<br/><br/>"
				+ "<p>Proposta de negocia&ccedil;&atilde;o para o produto.</p>"
				+ "<p>Dados do produto:</p><br/>"
				+ "<ul>"
				+ "<li><b>Nome:</b> " + produto.getNome() + "."
				+ "<li><b>Descri&ccedil;&atilde;o:</b> " + produto.getDescricao() + "."
				+ "<li><b>Pre&ccedil;o:</b> R$ " + produto.getPreco() + ".</li>"
				+ "</ul><br/>Proposta para o produto."				
				+ "<p><i>"	+ mensagem + "</i></p><br/>"
				+ "<hr width=\"100%\" size=\"2\"><br/>"
				+ "<p>Este email &eacute; autom&aacute;tico, para respond&ecirc;-lo utilize "
				+ "os servi&ccedil;os de nosso portal e entre em contato com "
				+ "<i>" + cliente.getNome() + "</i> ou clique no link abaixo e encaminhe sua contra-proposta</p><br/>" 
				+ "<div align=\"center\">" + cliente.getEmail() + "</div>"
				+ "<p>Equipe Compre e Venda</p>";
	}

	private String getAssunto(String assunto) {		
		return "Portal Compre e Venda. Notificação de " + assunto + ".";
	}

}

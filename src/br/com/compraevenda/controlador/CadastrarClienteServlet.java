package br.com.compraevenda.controlador;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.regex.Pattern;

import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.internet.AddressException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.hibernate.Session;

import br.com.compraevenda.dao.CategoriaDao;
import br.com.compraevenda.dao.ClienteDAO;
import br.com.compraevenda.dao.ProdutoDAO;
import br.com.compraevenda.dao.RedeSocialDAO;
import br.com.compraevenda.modelo.Categoria;
import br.com.compraevenda.modelo.Cliente;
import br.com.compraevenda.modelo.Produto;
import br.com.compraevenda.modelo.RedeSocial;
import br.com.compraevenda.util.Email;
import br.com.compraevenda.util.ImagemUtil;

import com.sun.mail.smtp.SMTPAddressFailedException;

public class CadastrarClienteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {
		
		boolean paginaComErro = false;
		boolean arquivoUpado = false;
		
		Cliente cliente = new Cliente();		
		cliente.setRedeSocial(new RedeSocial());
		
		String senha2 = "";
		cliente.setUrlImagem("fotoDefault.jpg");
		InputStream streamDaImagem = null;
		String nomeDoArquivo = "";
		String pagina = "/cliente.jsp";
		
		boolean termoDeContratoAceito = true;
				
		
		Session hibernateSession = (Session)request.getAttribute("session");
		ClienteDAO dao = new ClienteDAO(hibernateSession);
		RedeSocialDAO rsDao = new RedeSocialDAO(hibernateSession);
		
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);

		if (isMultipart) {

			FileItemFactory fact = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(fact);
			List<FileItem> items = null;

			try {
				items = (List<FileItem>) upload.parseRequest(request);
			} catch (FileUploadException e) {
				e.printStackTrace();
			}
			
			for (FileItem item : items) {
				if (item.isFormField()) {
					if ("nome".equals(item.getFieldName())) {
						cliente.setNome(item.getString());
					} else if ("email".equals(item.getFieldName())) {
						cliente.setEmail(item.getString());
					} else if ("usuario".equals(item.getFieldName())) {
						cliente.setUsuario(item.getString());
					} else if ("senha".equals(item.getFieldName())) {
						cliente.setSenha(item.getString());
					} else if ("senha2".equals(item.getFieldName())) {
						senha2 = item.getString();
					} else if ("notificacao".equals(item.getFieldName())) {
						cliente.setNotificacao(item.getString());
					} else if ("telefone".equals(item.getFieldName())) {
						cliente.setTelefone(item.getString());
					} else if ("autorizarTelefone".equals(item.getFieldName())) {
						cliente.setAutorizarTelefone(Boolean.valueOf(item.getString()));
					} else if ("endereco".equals(item.getFieldName())) {
						cliente.setEndereco(item.getString());
					} else if ("autorizarEndereco".equals(item.getFieldName())) {
						cliente.setAutorizarEndereco(Boolean.valueOf(item.getString()));
					} else if ("cidade".equals(item.getFieldName())){
						cliente.setCidade(item.getString());
					} else if ("estado".equals(item.getFieldName())){
						cliente.setEstado(item.getString());
					} else if ("orkut".equals(item.getFieldName())){
						cliente.getRedeSocial().setOrkut(item.getString());
					} else if ("facebook".equals(item.getFieldName())){
						cliente.getRedeSocial().setFacebook(item.getString());
					} else if ("twitter".equals(item.getFieldName())){
						cliente.getRedeSocial().setTwitter(item.getString());
					} else if ("termoDoContrato".equals(item.getFieldName())){
						termoDeContratoAceito = Boolean.valueOf(item.getString());						
					}
				} else {
					try {					
						nomeDoArquivo = item.getName();
						nomeDoArquivo = nomeDoArquivo.replaceAll(Pattern.quote("\\"), "");
						nomeDoArquivo = nomeDoArquivo.replaceAll(Pattern.quote(":"), "");
						
						streamDaImagem = item.getInputStream();
						if (!"".equals(nomeDoArquivo)) {
							arquivoUpado = true;
						}
					} catch (IOException e) {
						e.printStackTrace();
					}
				}				
			}
		}	
		
		if (!cliente.getRedeSocial().getOrkut().isEmpty() 
				&& !cliente.getRedeSocial().getOrkut().startsWith("http://")){
			String strOrkut = "http://" + cliente.getRedeSocial().getOrkut();
			cliente.getRedeSocial().setOrkut(strOrkut);
			request.setAttribute("orkut", cliente.getRedeSocial().getOrkut());
		}
		
		if (!cliente.getRedeSocial().getFacebook().isEmpty() 
				&& !cliente.getRedeSocial().getFacebook().startsWith("http://")){
			String strFacebook = "http://" + cliente.getRedeSocial().getFacebook();
			cliente.getRedeSocial().setFacebook(strFacebook);
		}		
		
		if (!cliente.getRedeSocial().getTwitter().isEmpty() 
				&& !cliente.getRedeSocial().getTwitter().startsWith("http://")){
			String strTwitter = "http://" + cliente.getRedeSocial().getTwitter();
			cliente.getRedeSocial().setTwitter(strTwitter);
		}
		
		
		if (!informacoesParaContatoSaoValidos(cliente)) {
			request.setAttribute("msgErro", true);						
			paginaComErro = true;
		}
		
		if (!dao.nomeDeUsuarioDisponivel(cliente.getUsuario())){			
			request.setAttribute("msgUsuario", true);			
			paginaComErro = true;
		}
		if (dao.emailJaEstaCadastrado(cliente.getEmail())){
			request.setAttribute("msgEmailIndisponivel", true);
			paginaComErro = true;
		}
		
		if (!informacoesDeAcessoAoSistemaSaoValidas(cliente)) {
			request.setAttribute("msgLogin", true);			
			paginaComErro = true;			
		}		
		
		if (!senhasConferem(cliente.getSenha(), senha2)) {
			request.setAttribute("msgSenha", true);		
			paginaComErro = true;			
		}	
		
		if (arquivoUpado) {
			if (arquivoEhFoto(nomeDoArquivo)) {
				cliente.setUrlImagem(nomeDoArquivo);							
			} else {
				request.setAttribute("msgFoto", true);
				paginaComErro = true;
			}
		}
		
		if (!termoDeContratoAceito){
			RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
			dispatcher.forward(request, response);
		} else if (paginaComErro) {
			request.setAttribute("nome", cliente.getNome());
			request.setAttribute("email", cliente.getEmail());
			request.setAttribute("usuario", cliente.getUsuario());
			request.setAttribute("telefone", cliente.getTelefone());
			request.setAttribute("cidade", cliente.getCidade());
			request.setAttribute("estado", cliente.getEstado());
			request.setAttribute("endereco", cliente.getEndereco());
			request.setAttribute("senha", cliente.getSenha());
			request.setAttribute("senha2", senha2);
			request.setAttribute("orkut", cliente.getRedeSocial().getOrkut());
			request.setAttribute("facebook", cliente.getRedeSocial().getFacebook());
			request.setAttribute("twitter", cliente.getRedeSocial().getTwitter());
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/cadastrarCliente.jsp");
			dispatcher.forward(request, response);
		} else {			
			try {
				new Email();
				Email.enviarEmail(
						getInitParameter("email"), 
						getInitParameter("senha"), 
						cliente.getEmail().trim(),
						getAssunto(), 
						geMmensagem(cliente));
			} catch (AddressException e) {
				pagina = "/resposta.jsp";
				request.setAttribute("codigo", "AE03");
				request.setAttribute("nome", cliente.getNome());
				e.printStackTrace();
			} catch (SMTPAddressFailedException e) {
				pagina = "/resposta.jsp";
				request.setAttribute("codigo", "SMTPAFE03");
				request.setAttribute("nome", cliente.getNome());
				e.printStackTrace();
			} catch (NoSuchProviderException e) {
				request.setAttribute("codigo", "NSPE03");
				request.setAttribute("nome", cliente.getNome());
				pagina = "/resposta.jsp";
				e.printStackTrace();
			} catch (MessagingException e) {
				request.setAttribute("codigo", "ME03");
				request.setAttribute("nome", cliente.getNome());
				pagina = "/resposta.jsp";
				e.printStackTrace();
			}
			
			dao.cadastrar(cliente);
			
			RedeSocial redeSocial = cliente.getRedeSocial();
			redeSocial.setCliente(cliente);
			rsDao.cadastrar(redeSocial);
			
			if (!"fotoDefault.jpg".equals(cliente.getUrlImagem()) && arquivoUpado) {
				String novaUrl = 
					cliente.getUsuario() + "_" + cliente.getIdcliente() + "_" + cliente.getUrlImagem();
				new ImagemUtil().salvarImagemNoServidor(novaUrl, streamDaImagem);
				cliente.setUrlImagem(novaUrl);
				dao.atualizar(cliente);
			}
			
			/*
			 * lista para preencher o menu list de categoria na pagina cliente.jsp
			 */
			CategoriaDao categoriaDao = new CategoriaDao(hibernateSession);			
			List<Categoria> categorias = categoriaDao.getCategorias();
			
			HttpSession session = request.getSession();
			session.setAttribute("cliente", cliente);
			session.setAttribute("categorias", categorias);			
			
			if (!termoDeContratoAceito){
				pagina = "/index.jsp";
			}
			
			RequestDispatcher dispatcher = request.getRequestDispatcher(pagina);
			dispatcher.forward(request, response);			
		}
	}

	private String getAssunto() {
		return "compraevenda.com confirmação de cadastro !";
	}
	
	private String geMmensagem(Cliente cliente) {		
		return "<b>compraevenda.com.br</b><br/><br/>Obrigado por cadastrar-se em nosso, seu login " +
				"de acesso &eacute;:<br/><p><b>usu&aacute;rio</b>: " + cliente.getUsuario() + "<br>" +
				" <b>senha</b>: " + cliente.getSenha() + "</p><p>Este email &eacute; autom&aacute;tico" +
				", favor n&atilde;o responder esta mensagem, para entrar em contato conosco utilize" +
				" nossos canais de contato atrav&eacute;z do site.</p>" +
				"<p><a href=\"http://localhost:8080/compraevenda.com.br\">nosso site</a></p>";
	}

	private boolean arquivoEhFoto(String nomeDaImagem) {
		return (nomeDaImagem.endsWith(".jpg") || nomeDaImagem.endsWith(".png") ||
				nomeDaImagem.endsWith(".JPG") || nomeDaImagem.endsWith(".PNG")) ? true : false;
	}

	private boolean senhasConferem(String senha1, String senha2) {
		if (senha1.isEmpty()) {
			return false;
		} else if (!senha2.equals(senha1)) {
			return false;
		}
		return true;
	}

	private boolean informacoesDeAcessoAoSistemaSaoValidas(Cliente cliente) {
		return (cliente.getUsuario().isEmpty()) ? false : true;
	}

	private boolean informacoesParaContatoSaoValidos(Cliente cliente) {
		return (cliente.getNome().isEmpty() || cliente.getEmail().isEmpty() || cliente.getCidade().isEmpty()) ? false : true;
	}
}

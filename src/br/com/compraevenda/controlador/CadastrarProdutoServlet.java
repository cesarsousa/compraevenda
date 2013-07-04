package br.com.compraevenda.controlador;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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

import com.sun.mail.smtp.SMTPAddressFailedException;

import br.com.compraevenda.dao.CategoriaDao;
import br.com.compraevenda.dao.ClienteDAO;
import br.com.compraevenda.dao.ImagemDAO;
import br.com.compraevenda.dao.ProdutoDAO;
import br.com.compraevenda.modelo.Categoria;
import br.com.compraevenda.modelo.Cliente;
import br.com.compraevenda.modelo.Imagem;
import br.com.compraevenda.modelo.Produto;
import br.com.compraevenda.util.Email;
import br.com.compraevenda.util.ImagemUtil;
 
public class CadastrarProdutoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	Produto produto = new Produto();
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {
		
		Map<Imagem, InputStream> mapaDeImagens = new HashMap<Imagem, InputStream>();
		
		boolean paginaComErro = false;
		Session hibernateSession = (Session)request.getAttribute("session");
		ClienteDAO clienteDao = new ClienteDAO(hibernateSession);		
		ProdutoDAO produtoDao = new ProdutoDAO(hibernateSession);
		CategoriaDao categoriaDao = new CategoriaDao(hibernateSession);
		
		String nomeDoArquivo = "";
		String preco = "";
		String categoriaOpt = "";
		String novaCategoria = "";
		String pagina = "/cliente.jsp";
		String idCategoriaOpt = "";
		
		
		boolean termoDeContratoAceito = true;
		
		HttpSession sessao = request.getSession();
		Cliente cliente =  (Cliente) sessao.getAttribute("cliente");		
		
		produto.setCliente(cliente);
		produto.setCategoria(new Categoria());
		
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		
		if (isMultipart){
			
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
						produto.setNome(item.getString());
					} else if ("preco".equals(item.getFieldName())) {
						preco = item.getString();
					} else if ("interesse".equals(item.getFieldName())) {
						produto.setInteresse(item.getString());
					} else if ("descricao".equals(item.getFieldName())) {
						produto.setDescricao(item.getString());
					} else if ("novaCategoria".equals(item.getFieldName()) && !item.getString().isEmpty()){
						novaCategoria = item.getString();
					} else if ("categoriaOpt".equals(item.getFieldName())){
						categoriaOpt = item.getString();
						System.out.println("..............................................." + item.getString());
						//categoriaOpt = item.getString().replace("[", "").replace("]", "");
					} else if ("termoDoContrato".equals(item.getFieldName())){
						termoDeContratoAceito = Boolean.valueOf(item.getString());						
					}
				} else {
					try {											
						nomeDoArquivo = item.getName();
						Imagem imagem = new Imagem();
						
						if (!nomeDoArquivo.isEmpty()) {
							
							nomeDoArquivo = nomeDoArquivo.replaceAll(Pattern.quote("\\"), "");
							nomeDoArquivo = nomeDoArquivo.replaceAll(Pattern.quote(":"), "");
							imagem.setUrlImagem(nomeDoArquivo);									
						}
						
						mapaDeImagens.put(imagem, item.getInputStream());
										
						
					} catch (IOException e) {
						e.printStackTrace();
					}
				}				
			}			
		}
		
		request.setAttribute("produto", produto);
		
		if (!novaCategoria.isEmpty()){			
			produto.getCategoria().setNome(novaCategoria);
		} else {
			produto.getCategoria().setNome(categoriaOpt);
		}	
		
		if (!camposSaoValidos(produto)){
			request.setAttribute("msgErro", true);
			paginaComErro = true;
		}
		
		if (!precoEhValido(preco)){
			request.setAttribute("msgPreco", true);
			paginaComErro = true;
		}		
		
		if (!arquivosSaoFotos(mapaDeImagens)){
			request.setAttribute("msgFoto", true);
			paginaComErro = true;
		}	
		
		if (!termoDeContratoAceito){
			RequestDispatcher dispatcher = request.getRequestDispatcher(pagina);
			dispatcher.forward(request, response);
		} else if (paginaComErro) {
			pagina = "/cadastrarProduto.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(pagina);
			dispatcher.forward(request, response);
		} else {
			
			if (!novaCategoria.isEmpty()){				
				categoriaDao.cadastrar(produto.getCategoria());
			}else{
				produto.setCategoria(categoriaDao.getByName(categoriaOpt));
			}
			produtoDao.cadastrar(produto);			
			
			Set<Imagem> chaves = mapaDeImagens.keySet();
			for (Imagem imagem : chaves){
				imagem.setProduto(produto);
				ImagemDAO imagemDao = new ImagemDAO(hibernateSession);
				imagemDao.cadastrar(imagem);				
				
				if (!ImagemUtil.PRODUTO_DEFAULT.equals(imagem.getUrlImagem())){
					String novaFoto = imagem.getIdimagem() + imagem.getUrlImagem();					
					new ImagemUtil().salvarImagemNoServidor(novaFoto, mapaDeImagens.get(imagem));
					imagem.setUrlImagem(novaFoto);
					imagemDao.atualizar(imagem);
				}								
			}			
			
			Cliente clienteAtualizado = clienteDao.getCliente(cliente.getUsuario(), cliente.getSenha());
						
			sessao.removeAttribute("cliente");
			sessao.setAttribute("cliente", clienteAtualizado);
			
			
			List<String> emailParaNotificacao = clienteDao.getEmailParaNotificacao();
			for (String email : emailParaNotificacao){
				try {
					enviarMsg(email, getAssunto(), getMensagem(produto));
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
			}
			
			RequestDispatcher dispatcher = request.getRequestDispatcher(pagina);
			dispatcher.forward(request, response);			
		}
		
	}

	private boolean precoEhValido(String preco) {		
		try {
			produto.setPreco(Double.valueOf(preco));
		}catch (NumberFormatException e) {
			e.printStackTrace();
			return false;			
		}		
		return true;		
	}

	private boolean arquivosSaoFotos(Map<Imagem, InputStream> mapaDeImagens) {
		Set<Imagem> chaves = mapaDeImagens.keySet();
		for (Imagem imagem : chaves){
			if (!imagemEhFoto(imagem.getUrlImagem())){
				return false;
			}
		}
		return true;
	}
	
	private boolean imagemEhFoto(String urlImagem) {
		return (urlImagem.endsWith(".jpg") || urlImagem.endsWith(".png") ||
				urlImagem.endsWith(".JPG") || urlImagem.endsWith(".PNG")) ? true : false;
	}

	private boolean camposSaoValidos(Produto produto) {
		return (produto.getNome().isEmpty() || produto.getDescricao().isEmpty()) ? false : true;
	}
	
	private void enviarMsg(String destino, String assunto, String mensagem) throws AddressException, SMTPAddressFailedException, NoSuchProviderException, MessagingException {
		Email.enviarEmail(getInitParameter("email"), getInitParameter("senha"), destino, assunto, mensagem);	
	}
	
	private String getMensagem(Produto produto) {
		return
		"<div align=\"center\"><font size=\"5\">Portal Compre e Venda De Tudo</font><br/></div>"
		+ "Novo produto postado por " + produto.getCliente().getNome() + ".<br/><br/>"		
		+ "<p>Dados do produto:</p><br/>"
		+ "<ul>"
		+ "<li><b>Nome:</b> " + produto.getNome() + "."
		+ "<li><b>Descri&ccedil;&atilde;o:</b> " + produto.getDescricao() + "."
		+ "<li><b>Pre&ccedil;o:</b> R$ " + produto.getPreco() + ".</li>"
		+ "</ul><br/>"				
		+ "<hr width=\"100%\" size=\"2\"><br/>"
		+ "<p>Este email &eacute; autom&aacute;tico, para respond&ecirc;-lo utilize "
		+ "os servi&ccedil;os de nosso portal e entre em contato com "
		+ "<i>" + produto.getCliente().getNome() + "</i> ou clique no link abaixo e encaminhe sua contra-proposta</p><br/>" 
		+ "<div align=\"center\">" +  produto.getCliente().getEmail() + "</div>"
		+ "<p>Equipe Compre e Venda</p>";
	}

	private String getAssunto() {
		return "Portal Compre e Venda. Novo produto postado.";
	}
}

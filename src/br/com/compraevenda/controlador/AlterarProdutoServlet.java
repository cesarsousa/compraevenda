package br.com.compraevenda.controlador;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Pattern;

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

import br.com.compraevenda.dao.ClienteDAO;
import br.com.compraevenda.dao.ImagemDAO;
import br.com.compraevenda.dao.ProdutoDAO;
import br.com.compraevenda.modelo.Categoria;
import br.com.compraevenda.modelo.Cliente;
import br.com.compraevenda.modelo.Imagem;
import br.com.compraevenda.modelo.Produto;
import br.com.compraevenda.util.ImagemUtil;


public class AlterarProdutoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;  
	
	private Produto produtoSessao = new Produto();	
	
	protected void service(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {
		
		Map<Imagem, InputStream> mapaDeImagensNovas = new HashMap<Imagem, InputStream>();
		
		HttpSession httpSession = request.getSession();
		Cliente cliente = (Cliente)httpSession.getAttribute("cliente");
		int idClienteSessao = cliente.getIdcliente();
		
		boolean busca = Boolean.valueOf(request.getParameter("busca"));
		
		Session hibernateSession = (Session)request.getAttribute("session");
		ProdutoDAO produtoDao = new ProdutoDAO(hibernateSession);
		ClienteDAO clienteDAO = new ClienteDAO(hibernateSession);
		
		Produto produto = new Produto();
		produto.setCategoria(new Categoria());
		
		if (busca) {
			/*
			 * requisição de cliente.jsp. Faz a busca na base de dados do
			 * produto que será alterado. 
			 */
			
			int idProduto = Integer.valueOf(request.getParameter("idproduto"));		
			Produto produtoDaBusca = produtoDao.getProduto(idProduto);

			request.setAttribute("produto", produtoDaBusca);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/alterarProduto.jsp");
			dispatcher.forward(request, response);
		} else {
			/*
			 * requisição de alterarProduto.jsp. Faz a alteração dos dados
			 * do produto na base de dados.
			 */			
			
			boolean paginaComErro = false;
			String nomeDoArquivo = "";
			String preco = "";
			List<String> fotosARemover = new ArrayList<String>();
			
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
						} else if ("categoria".equals(item.getFieldName())){
							produto.getCategoria().setNome(item.getString());
						} else if ("removerFoto".equals(item.getFieldName())){
							fotosARemover.add(item.getString());
						} else if ("idProduto".equals(item.getFieldName())){							
							int idProdutoDaSessao = Integer.valueOf(item.getString());														
							produtoSessao = produtoDao.getProduto(idProdutoDaSessao);
						}
					} else {
						try {												
							nomeDoArquivo = item.getName();
							
							Imagem imagem = new Imagem();
							System.out.println("...............item.getname " +nomeDoArquivo);						
							
							if (!nomeDoArquivo.isEmpty()) {								
								nomeDoArquivo = nomeDoArquivo.replaceAll(Pattern.quote("\\"), "");
								nomeDoArquivo = nomeDoArquivo.replaceAll(Pattern.quote(":"), "");
								
								imagem.setUrlImagem(nomeDoArquivo);
								System.out.println("imagem add no mapa novas "+ imagem.getUrlImagem());
								mapaDeImagensNovas.put(imagem, item.getInputStream());
							}													
							
						} catch (IOException e) {
							e.printStackTrace();
						}
					}				
				}
				
				if (!produto.getNome().isEmpty()){
					produtoSessao.setNome(produto.getNome());
				}			
				
				if (!produto.getDescricao().isEmpty()){
					produtoSessao.setDescricao(produto.getDescricao());
				}
				
				if (!produto.getCategoria().getNome().isEmpty()){
					produtoSessao.setCategoria(produto.getCategoria());
				}
				
				if (!preco.isEmpty()){
					if (!precoEhValido(preco)){
						request.setAttribute("msgPreco", preco);
						paginaComErro = true;
					}					
				}			
				
				if (!arquivosSaoFotos(mapaDeImagensNovas)){
					request.setAttribute("msgFoto", true);
					paginaComErro = true;
				}
				
				if (paginaComErro){
					request.setAttribute("produto", produtoSessao);
					request.setAttribute("nome", produto.getNome());
					request.setAttribute("preco", preco);
					request.setAttribute("descricao", produto.getDescricao());
					request.setAttribute("categoria", produto.getCategoria());
					
					RequestDispatcher dispatcher = request.getRequestDispatcher("/alterarProduto.jsp");
					dispatcher.forward(request, response);
				}else{
					ProdutoDAO produtoDAO = new ProdutoDAO(hibernateSession);
					
					// TODO tratar excecão RuntimeException
					if (produtoSessao.getCliente() == null){
						throw new RuntimeException("produto com cliente nulo");
					}
					produtoDAO.alterar(produtoSessao);
					
					Set<Imagem> chaves = mapaDeImagensNovas.keySet();
					
					List<Imagem> imagensDoProdutoSessao = produtoSessao.getImagens();
					
					for (Imagem imagemNova : chaves){
						
						for (Imagem imagemDoProduto : imagensDoProdutoSessao){
							if (ImagemUtil.PRODUTO_DEFAULT.equals(imagemDoProduto.getUrlImagem())){
								String novaFoto = imagemDoProduto.getIdimagem() + imagemNova.getUrlImagem();								
								
								imagemDoProduto.setUrlImagem(novaFoto);
								
								new ImagemUtil().salvarImagemNoServidor(novaFoto, mapaDeImagensNovas.get(imagemNova));
								ImagemDAO imagemDao = new ImagemDAO(hibernateSession);
								imagemDao.atualizar(imagemDoProduto);
								break;
							}
						}
					}			
					
					if (!fotosARemover.isEmpty()){						
						for (String imagemARemover : fotosARemover){							
							Imagem imagem = getImagemARemover(imagemARemover, imagensDoProdutoSessao);							
							new ImagemUtil().deletarImagemDoservidor(imagem.getUrlImagem());
							imagem.setUrlImagem(ImagemUtil.PRODUTO_DEFAULT);							
							ImagemDAO imagemDao = new ImagemDAO(hibernateSession);							
							imagemDao.atualizar(imagem);
						}
					}
					
					Cliente clienteSessaoAtualizado = clienteDAO.getCliente(idClienteSessao);
					httpSession.removeAttribute("cliente");
					httpSession.setAttribute("cliente", clienteSessaoAtualizado);
					RequestDispatcher dispatcher = request.getRequestDispatcher("/cliente.jsp");
					request.setAttribute("produtoAlterado", true);
					dispatcher.forward(request, response);
				}				
			}
		}
	}

	private Imagem getImagemARemover(String imagemARemover, List<Imagem> imagensDoProdutoSessao) {
		for (Imagem imagem : imagensDoProdutoSessao){
			if (imagemARemover.equals(imagem.getUrlImagem())){
				return imagem;
			}
		}
		// TODO tratar exceção IllegalStateException
		throw new IllegalStateException("erro. imagem: " + imagemARemover
				+ " não encontrada na lista de imagens do produto.");
	}

	private boolean arquivosSaoFotos(Map<Imagem, InputStream> mapaDeImagensNovas) {
		Set<Imagem> chaves = mapaDeImagensNovas.keySet();
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

	private boolean precoEhValido(String preco) {		
		try {			
			produtoSessao.setPreco(Double.valueOf(preco));
		}catch (NumberFormatException e) {
			e.printStackTrace();
			return false;			
		}		
		return true;		
	}

}

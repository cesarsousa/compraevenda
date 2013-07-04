package br.com.compraevenda.controlador;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;

import br.com.compraevenda.dao.ClienteDAO;
import br.com.compraevenda.modelo.Cliente;
import br.com.compraevenda.modelo.Imagem;
import br.com.compraevenda.modelo.Produto;
import br.com.compraevenda.util.ImagemUtil;


public class DeletarClienteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   ImagemUtil imgUtil = new ImagemUtil();	
	
	protected void service(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {
		
		Session hibernateSession = (Session)request.getAttribute("session");
		ClienteDAO clienteDao = new ClienteDAO(hibernateSession);		
		
		HttpSession session = request.getSession();
		Cliente cliente = (Cliente)session.getAttribute("cliente");
		
		clienteDao.deletar(cliente);
		
		deletarClienteDoServidor(cliente);	
		
		session.invalidate();
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
		dispatcher.forward(request, response);		
	}

	private void deletarClienteDoServidor(Cliente cliente) {
		if (cliente.getProdutos() != null) {
			for (Produto produto : cliente.getProdutos()) {
				deletarImagens(produto.getImagens());
			}
		}
		if (!"fotoDefault.jpg".equals(cliente.getUrlImagem())) {
			imgUtil.deletarImagemDoservidor(cliente.getUrlImagem());
		}		
	}
	
	private void deletarImagens(List<Imagem> imagens) {
		for (Imagem imagem : imagens) {
			if (!"produtoDefault.jpg".equals(imagem.getUrlImagem())) {
				imgUtil.deletarImagemDoservidor(imagem.getUrlImagem());
			}
		}
	}
}

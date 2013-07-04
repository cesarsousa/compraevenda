package br.com.compraevenda.controlador;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;

import br.com.compraevenda.dao.ClienteDAO;
import br.com.compraevenda.dao.ProdutoDAO;
import br.com.compraevenda.modelo.Imagem;
import br.com.compraevenda.modelo.Produto;
import br.com.compraevenda.util.ImagemUtil;

public class DeletarProdutoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void service(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {	

		int idProduto = Integer.valueOf(request.getParameter("idproduto"));
		int idcliente = Integer.valueOf(request.getParameter("idcliente"));	

		Session hibernateSession = (Session)request.getAttribute("session");
		ClienteDAO clienteDao = new ClienteDAO(hibernateSession);
		ProdutoDAO produtoDao = new ProdutoDAO(hibernateSession);
		
		Produto produto = produtoDao.getProduto(idProduto);
		for (Imagem imagem : produto.getImagens()) {
			if (!"produtoDefault.jpg".equals(imagem.getUrlImagem())) {
				new ImagemUtil().deletarImagemDoservidor(imagem.getUrlImagem());
			}
		}
		
		produtoDao.deletar(produto);		
		
		HttpSession session = request.getSession();
		session.setAttribute("cliente", clienteDao.getCliente(idcliente));
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/cliente.jsp");
		dispatcher.forward(request, response);
	}

}

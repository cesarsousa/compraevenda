package br.com.compraevenda.controlador;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import br.com.compraevenda.dao.ProdutoDAO;
import br.com.compraevenda.modelo.Produto;


public class BuscaProdutoIndexServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;  

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {

		String produto  = request.getParameter("produto");
		
		Session hibernateSession = (Session)request.getAttribute("session");
		ProdutoDAO produtoDao = new ProdutoDAO(hibernateSession);
		List<Produto> produtosDaBusca = produtoDao.listarTodos(produto, null);
		
		if (produtosDaBusca.isEmpty()){			
			request.setAttribute("BuscaSemSucesso", true);
			request.setAttribute("parametro", produto);			
		} else {			
			request.setAttribute("produtosDaBusca", produtosDaBusca);
		}
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
		dispatcher.forward(request, response);
	}

}

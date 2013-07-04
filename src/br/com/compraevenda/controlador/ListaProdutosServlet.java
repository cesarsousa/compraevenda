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

public class ListaProdutosServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		Session hibernateSession = (Session) request.getAttribute("session");
		ProdutoDAO dao = new ProdutoDAO(hibernateSession);
		
		List<Produto> produtos = dao.listarOsTop5();	

		request.setAttribute("produtos", produtos);		
		request.setAttribute("primeiraExecucao", true);		

		RequestDispatcher dispatcher = request
				.getRequestDispatcher("/index.jsp");
		dispatcher.forward(request, response);
	}	
}

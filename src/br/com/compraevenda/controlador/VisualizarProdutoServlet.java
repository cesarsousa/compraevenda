package br.com.compraevenda.controlador;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;

import org.hibernate.Session;

import br.com.compraevenda.dao.ProdutoDAO;
import br.com.compraevenda.modelo.Produto;

public class VisualizarProdutoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		int id = Integer.parseInt(request.getParameter("id"));		

		Session hibernateSession = (Session)request.getAttribute("session");
		ProdutoDAO produtoDao = new ProdutoDAO(hibernateSession);
		Produto produto = produtoDao.getProduto(id);

		request.setAttribute("produto", produto);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/produto.jsp");
		dispatcher.forward(request, response);
	}

}

package br.com.compraevenda.controlador;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import br.com.compraevenda.dao.ClienteDAO;
import br.com.compraevenda.modelo.Cliente;


public class VisualizarClienteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {

		int id = Integer.valueOf(request.getParameter("id"));
		
		Session hibernateSession = (Session)request.getAttribute("session");
		ClienteDAO clienteDao = new ClienteDAO(hibernateSession);
		Cliente cliente = clienteDao.getCliente(id);
		
		request.setAttribute("perfil", cliente);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/perfil.jsp");
		dispatcher.forward(request, response);		
	}
}

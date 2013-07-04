package br.com.compraevenda.controlador;

import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;

import br.com.compraevenda.dao.CategoriaDao;
import br.com.compraevenda.dao.ClienteDAO;
import br.com.compraevenda.dao.ProdutoDAO;
import br.com.compraevenda.modelo.Categoria;
import br.com.compraevenda.modelo.Cliente;
import br.com.compraevenda.modelo.Produto;

public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {
		
		String pagina = "";
		
		String usuario = request.getParameter("usuario");
		String senha = request.getParameter("senha");
		
		Session hibernateSession = (Session)request.getAttribute("session");		
		ClienteDAO clientaDao = new ClienteDAO(hibernateSession);
		CategoriaDao categoriaDao = new CategoriaDao(hibernateSession);
		Cliente cliente = clientaDao.getCliente(usuario, senha);
		
		if (cliente == null){			
			request.setAttribute("msgErroLogin", true);			
			pagina = "/index.jsp";
		} else {			
			
			List<Categoria> categorias = categoriaDao.getCategorias();		
			
			HttpSession session = request.getSession();
			session.setAttribute("cliente", cliente);
			session.setAttribute("categorias", categorias);
			pagina = "/cliente.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(pagina);
		dispatcher.forward(request, response);		
	}	
}

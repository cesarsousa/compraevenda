package br.com.compraevenda.controlador;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ADMServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user = request.getParameter("user");
		String password = request.getParameter("password");
		
		if (!user.equals(getInitParameter("user")) 
				|| !password.equals(getInitParameter("password"))){
			request.setAttribute("msgErro", true);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/loginAdministrador.jsp");
			dispatcher.forward(request, response);
		}else{
			
		}
	}

}

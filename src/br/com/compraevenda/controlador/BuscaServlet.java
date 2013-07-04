package br.com.compraevenda.controlador;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

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

public class BuscaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
	throws ServletException, IOException {
		
		
		Session hibernateSession = (Session)request.getAttribute("session");
		ClienteDAO clienteDao = new ClienteDAO(hibernateSession);
		ProdutoDAO produtoDao = new ProdutoDAO(hibernateSession);
		CategoriaDao categoriaDao = new CategoriaDao(hibernateSession);
		List<Cliente> clientesDaBusca = new ArrayList<Cliente>();
		List<Produto> produtosDaBusca = new ArrayList<Produto>();		
		
		boolean optProduto = Boolean.valueOf(request.getParameter("optProduto"));	
		boolean optPessoa = Boolean.valueOf(request.getParameter("optPessoa"));
		
		if (optProduto){
			String produto = request.getParameter("produto");
			String categoria = request.getParameter("categoria");
			
			if (buscaPorCategoria(categoria)){
				if (produto.isEmpty()){
					produtosDaBusca = produtoDao.listarTodos(null, categoria);
				}else {
					produtosDaBusca = produtoDao.listarTodos(produto, categoria);
				}
			}else{
				
				if (produto.isEmpty()){
					request.setAttribute("buscaProdutoSemParametro", true);				
				} else{
					produtosDaBusca = produtoDao.listarTodos(produto, null);									
				}				
			}
			
			if (produtosDaBusca.isEmpty()){
				request.setAttribute("buscaProdutoSemSucesso", produtosDaBusca.size());
			} else{
				request.setAttribute("buscaProdutoComSucesso", produtosDaBusca.size());
				request.setAttribute("parametro", produto);
				request.setAttribute("produtosDaBusca", produtosDaBusca);
			}			
		}
		
		if (optPessoa){
			String pessoa = request.getParameter("pessoa");
			if (pessoa.isEmpty()){
				request.setAttribute("buscaPessoaSemParametro", true);				
			} else{
				clientesDaBusca = clienteDao.listarTodos(pessoa);
				if (clientesDaBusca.isEmpty()){
					request.setAttribute("buscaPessoaSemSucesso", clientesDaBusca.size());
				} else{
					request.setAttribute("buscaPessoaComSucesso", clientesDaBusca.size());
					request.setAttribute("parametro", pessoa);
					request.setAttribute("clientesDaBusca", clientesDaBusca);
				}				
			}
		}
		
		
		List<Categoria> categorias = categoriaDao.getCategorias();			
		request.setAttribute("categorias", categorias);
		
		HttpSession session = request.getSession();		
		session.setAttribute("categorias", categorias);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/cliente.jsp");
		dispatcher.forward(request, response);
	}

	private boolean buscaPorCategoria(String categoria) {		
		return "all".equals(categoria) ? false : true;
	}		
}

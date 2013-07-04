package br.com.compraevenda.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import br.com.compraevenda.modelo.Categoria;

public class CategoriaDao {
	
	private Session sessao;

	public CategoriaDao(Session sessao) {
		this.sessao = sessao;
	}

	@SuppressWarnings("unchecked")
	public List<Categoria> getCategorias() {
		List<Categoria> categorias = new ArrayList<Categoria>();
		categorias = (List<Categoria>) sessao.createSQLQuery(
				"select * from categoria order by nome").addEntity(Categoria.class).list();
		return categorias;
	}

	public void cadastrar(Categoria categoria) {
		Transaction tx = sessao.beginTransaction();
		sessao.update(categoria);
		tx.commit();	
	}

	public Categoria getById(int idCategoriaOpt) {		
		return (Categoria) sessao.createSQLQuery(
				"select * from categoria where idCategoria=" + idCategoriaOpt).addEntity(Categoria.class).uniqueResult();
	}

	public Categoria getByName(String categoriaOpt) {
		return (Categoria) sessao.createSQLQuery(
				"select * from categoria where nome='" + categoriaOpt + "'").addEntity(Categoria.class).uniqueResult();
	}

}

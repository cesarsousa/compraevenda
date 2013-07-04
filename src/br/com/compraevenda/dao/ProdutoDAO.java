package br.com.compraevenda.dao;


import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import br.com.compraevenda.modelo.Produto;

public class ProdutoDAO {
		
		private Session sessao;

		public ProdutoDAO(Session session) {
			this.sessao = session;
		}
		
		public void cadastrar(Produto produto){
			Transaction tx = sessao.beginTransaction();
			sessao.save(produto);
			tx.commit();			
		}
		
		public Produto getProduto(int idProduto){
			Produto produto = (Produto) sessao.createSQLQuery(
					"select * from produto where idproduto='" + idProduto + "'")
					.addEntity(Produto.class).uniqueResult();
			return produto;
		}
		
	public void deletar(Produto produto) {
		Transaction tx = sessao.beginTransaction();		
		sessao.delete(produto);
		tx.commit();		
		}

	@SuppressWarnings("unchecked")
	public List<Produto> listarTodos() {
		List<Produto> produtos = new ArrayList<Produto>();
		produtos = (List<Produto>) sessao.createSQLQuery(
				"select * from produto").addEntity(Produto.class).list();		
		return produtos;
	}
	
	@SuppressWarnings("unchecked")
	public List<Produto> listarOsTop5() {
		List<Produto> produtos = new ArrayList<Produto>();
		produtos = (List<Produto>) sessao.createSQLQuery(
				"select * from produto order by dtCadastro desc limit 10 ").addEntity(Produto.class).list();		
		return produtos;
	}

	@SuppressWarnings("unchecked")
	public List<Produto> listarTodos(String produto, String categoria) {
		List<Produto> produtos = new ArrayList<Produto>();
		List<Produto> produtosSolicitados = new ArrayList<Produto>();
		
		if (produto == null && categoria != null){
			produtosSolicitados = (List<Produto>) sessao.createSQLQuery(
			"select * from produto where categoria='" + categoria +"'").addEntity(Produto.class).list();
		} else if (produto != null && categoria != null){
			produtos = (List<Produto>) sessao.createSQLQuery(
					"select * from produto where categoria='" + categoria +"'").addEntity(Produto.class).list();
			for (Produto p : produtos){
				if (p.getNome().contains(produto) || p.getDescricao().contains(produto)){
					produtosSolicitados.add(p);
				}
			}
		} else {
			produtos = (List<Produto>) sessao.createSQLQuery(
			"select * from produto").addEntity(Produto.class).list();
			
			for (Produto p : produtos){
				if (p.getNome().contains(produto) || p.getDescricao().contains(produto)){
					produtosSolicitados.add(p);
				}
			}		
		}	
				
		return produtosSolicitados;
	}

	public void alterar(Produto produto) {
		Transaction tx = sessao.beginTransaction();
		sessao.update(produto);
		tx.commit();		
	}	
}

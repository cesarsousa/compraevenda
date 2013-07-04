package br.com.compraevenda.dao;

import org.hibernate.Session;
import org.hibernate.Transaction;

import br.com.compraevenda.modelo.Imagem;

public class ImagemDAO {
	
	private Session sessao;

	public ImagemDAO(Session session) {
		this.sessao = session;
	}	

	public void cadastrar(Imagem imagem) {
		Transaction tx = sessao.beginTransaction();
		sessao.save(imagem);
		tx.commit();			
	}

	public void deletar(Imagem imagem) {
		Transaction tx = sessao.beginTransaction();
		sessao.delete(imagem);
		tx.commit();		
	}

	public void atualizar(Imagem imagem) {
		Transaction tx = sessao.beginTransaction();
		sessao.update(imagem);
		tx.commit();		
	}
}

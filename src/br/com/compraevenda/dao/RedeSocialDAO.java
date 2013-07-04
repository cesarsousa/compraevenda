package br.com.compraevenda.dao;

import org.hibernate.Session;
import org.hibernate.Transaction;

import br.com.compraevenda.modelo.RedeSocial;

public class RedeSocialDAO {
	
	private Session sessao;
	
	public RedeSocialDAO(Session sessao) {
		this.sessao = sessao;
	}
	
	public void cadastrar(RedeSocial redeSocial){
		Transaction tx = sessao.beginTransaction();
		sessao.save(redeSocial);
		tx.commit();		
	}

	public void atualizar(RedeSocial redeSocial) {		
		Transaction tx = sessao.beginTransaction();
		sessao.update(redeSocial);
		tx.commit();
		
	}
}

package br.com.compraevenda.util;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.AnnotationConfiguration;

public class CriadorDeSession {

	public static Session getSession() {
		AnnotationConfiguration configuracao = new AnnotationConfiguration().configure();
		
		SessionFactory fabricaDeConexao = configuracao.buildSessionFactory();
		Session session = fabricaDeConexao.openSession();
		return session;
	}

}

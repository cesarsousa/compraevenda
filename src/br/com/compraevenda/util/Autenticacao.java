package br.com.compraevenda.util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class Autenticacao extends Authenticator {
	
	private final String email;
	private final String senha;	

	public Autenticacao(String email, String senha) {
		this.email = email;
		this.senha = senha;
	}

	protected PasswordAuthentication getPasswordAuthentication() {		
		return new PasswordAuthentication(email, senha);
	}	
}

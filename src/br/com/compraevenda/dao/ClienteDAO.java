package br.com.compraevenda.dao;

import java.util.ArrayList;
import java.util.List;

import javax.swing.text.StyledEditorKit.BoldAction;

import org.hibernate.Session;
import org.hibernate.Transaction;

import br.com.compraevenda.modelo.Cliente;

public class ClienteDAO {

	private Session sessao;
	
	public ClienteDAO(Session session) {
		this.sessao = session;
	}

	public void cadastrar(Cliente cliente){
		Transaction tx = sessao.beginTransaction();
		sessao.save(cliente);
		tx.commit();		
	}

	public boolean nomeDeUsuarioDisponivel(String usuario) {
		Object cliente = sessao.createSQLQuery(
				"select * from cliente where usuario='" + usuario + "'")
				.uniqueResult();
		if (cliente == null) {
			return true;
		}
		return false;

	}

	public boolean emailJaEstaCadastrado(String email) {
		Object cliente = sessao.createSQLQuery(
				"select * from cliente where email='" + email + "'")
				.uniqueResult();
		if (cliente == null) {
			return false;
		}
		return true;
	}

	public Cliente getCliente(String usuario, String senha) {
		Cliente cliente = (Cliente) sessao.createSQLQuery(
				"select * from cliente where usuario='" + usuario
						+ "' and senha='" + senha + "'").addEntity(Cliente.class).uniqueResult();		
		return cliente;
	}	

	public Cliente getCliente(String email) {
		Cliente cliente = (Cliente) sessao.createSQLQuery(
				"select * from cliente where email='" + email + "'").addEntity(Cliente.class).uniqueResult();
		return cliente;
	}

	public Cliente getCliente(int idcliente) {
		Cliente cliente = (Cliente) sessao.createSQLQuery(
				"select * from cliente where idcliente='" + idcliente + "'")
				.addEntity(Cliente.class).uniqueResult();
		return cliente;
	}

	public void atualizar(Cliente clienteSessao) {
		Transaction tx = sessao.beginTransaction();
		sessao.update(clienteSessao);
		tx.commit();				
	}

	@SuppressWarnings("unchecked")
	public List<Cliente> listarTodos() {
		List<Cliente> clientes = sessao.createCriteria(Cliente.class).list();		
		return clientes;
	}

	@SuppressWarnings("unchecked")
	public List<Cliente> listarTodos(String cliente) {
		List<Cliente> clientes = new ArrayList<Cliente>();
		clientes = (List<Cliente>)sessao.createSQLQuery(
				"select * from cliente").addEntity(Cliente.class).list();
		
		List<Cliente> clientesSolicitados = new ArrayList<Cliente>();
		for (Cliente c : clientes){
			if (c.getNome().contains(cliente)){
				clientesSolicitados.add(c);
			}
		}
		
		return clientesSolicitados;
	}

	public void deletar(Cliente cliente) {
		Transaction tx = sessao.beginTransaction();
		sessao.delete(cliente);
		tx.commit();		
	}

	@SuppressWarnings("unchecked")
	public List<String> getEmailParaNotificacao() {
		List<Cliente> clientes = new ArrayList<Cliente>();
		clientes = (List<Cliente>)sessao.createSQLQuery(
				"select * from cliente").addEntity(Cliente.class).list();
		
		List<String> emails = new ArrayList<String>();
		for (Cliente cliente : clientes){
			if (Boolean.valueOf(cliente.getNotificacao())){
				emails.add(cliente.getEmail());
			}
		}
		
		return emails;
	}	
}

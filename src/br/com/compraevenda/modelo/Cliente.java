package br.com.compraevenda.modelo;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="cliente")
public class Cliente {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int idcliente;

	private String nome;
	private String telefone;
	private String email;
	private String cidade;
	private String estado;
	private String endereco;
	private String notificacao;
	private String urlImagem;
	private String usuario;
	private String senha;
	private boolean autorizarEndereco;
	private boolean autorizarTelefone;

	@OneToMany(mappedBy = "cliente", fetch = FetchType.LAZY, cascade=CascadeType.ALL)
	private List<Produto> produtos;
	
	@OneToOne(mappedBy = "cliente")
	private RedeSocial redeSocial;
	
	public Cliente() {
		endereco = "endere�o n�o dispon�vel";
		telefone = "telefone n�o dispon�vel";
	}

	public int getIdcliente() {
		return idcliente;
	}

	public void setIdcliente(int idcliente) {
		this.idcliente = idcliente;
	}

	public void setProdutos(List<Produto> produtos) {
		this.produtos = produtos;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getTelefone() {
		return telefone;
	}

	public void setTelefone(String telefone) {
		this.telefone = telefone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCidade() {
		return cidade;
	}

	public void setCidade(String cidade) {
		this.cidade = cidade;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public String getEndereco() {
		return endereco;
	}

	public void setEndereco(String endereco) {
		this.endereco = endereco;
	}

	public String getUrlImagem() {
		return urlImagem;
	}

	public void setUrlImagem(String urlImagem) {
		this.urlImagem = urlImagem;
	}

	public String getUsuario() {
		return usuario;
	}

	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}

	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) {
		this.senha = senha;
	}

	public List<Produto> getProdutos() {
		return produtos;
	}

	public void adicionarProduto(Produto produto) {
		this.produtos.add(produto);
	}

	public String getNotificacao() {
		return notificacao;
	}

	public void setNotificacao(String notificacao) {
		this.notificacao = notificacao;
	}

	public void setRedeSocial(RedeSocial redeSocial) {
		this.redeSocial = redeSocial;
	}

	public RedeSocial getRedeSocial() {
		return redeSocial;
	}	
	
	public boolean isAutorizarEndereco() {
		return autorizarEndereco;
	}

	public void setAutorizarEndereco(boolean autorizarEndereco) {
		this.autorizarEndereco = autorizarEndereco;
	}

	public boolean isAutorizarTelefone() {
		return autorizarTelefone;
	}

	public void setAutorizarTelefone(boolean autorizarTelefone) {
		this.autorizarTelefone = autorizarTelefone;
	}
	
	public boolean isFoto(){
		return "fotoDefault.jpg".equals(urlImagem) ? false : true;
	}

	public String getTotalDeProdutos(){
		return Integer.toString(produtos.size());
	}
}

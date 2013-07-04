package br.com.compraevenda.modelo;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name="produto")
public class Produto {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int idproduto;
	
	@ManyToOne
	private Cliente cliente;
	
	@ManyToOne
	private Categoria categoria;
	
	private String nome;

	private String descricao;

	private double preco;

	private String interesse;

	@Temporal(TemporalType.DATE)
	private Date dtCadastro;

	@OneToMany(mappedBy = "produto", fetch = FetchType.LAZY, cascade=CascadeType.ALL)
	private List<Imagem> imagens;

	public Produto() {
		dtCadastro = new Date();		
	}

	public int getIdproduto() {
		return idproduto;
	}

	public void setIdproduto(int idproduto) {
		this.idproduto = idproduto;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public double getPreco() {
		return preco;
	}

	public void setPreco(double preco) {
		this.preco = preco;
	}

	public String getInteresse() {
		return interesse;
	}

	public void setInteresse(String interesse) {
		this.interesse = interesse;
	}

	public Date getDtCadastro() {
		return dtCadastro;
	}

	public void setDtCadastro(Date dtCadastro) {
		this.dtCadastro = dtCadastro;
	}

	public List<Imagem> getImagens() {
		return imagens;
	}

	public void adicionarImagem(Imagem imagem) {
		this.imagens.add(imagem);
	}

	public Cliente getCliente() {
		return cliente;
	}

	public void setCliente(Cliente cliente) {
		this.cliente = cliente;
	}

	public void setImagens(List<Imagem> imagens) {
		this.imagens = imagens;
	}	

	public Categoria getCategoria() {
		return categoria;
	}

	public void setCategoria(Categoria categoria) {
		this.categoria = categoria;
	}

	public String getFoto1(){
		return imagens.get(0).getUrlImagem();
	}
	
	public String getFoto2(){
		return imagens.get(1).getUrlImagem();
	}
	
	public String getFoto3(){
		return imagens.get(2).getUrlImagem();
	}
	
	public String getFoto4(){
		return imagens.get(3).getUrlImagem();
	}
	
	public String getFotoPrincipal(){		
		try {
			for (Imagem imagem : imagens){
				if (!"produtoDefault.jpg".equals(imagem.getUrlImagem())){
					return imagem.getUrlImagem();
				}
			}
			return "produtoDefault.jpg";
		} catch (NullPointerException e) {			
			e.printStackTrace();
			return "produtoDefault.jpg";
		}
	}
	
	public String getDataFormatada() {
		String data;
		//String hora;

		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd/MM/yyyy");
		data = simpleDateFormat.format(dtCadastro);

		//simpleDateFormat = new SimpleDateFormat("hh:mm:ss");
		//hora = simpleDateFormat.format(dtCadastro);

		return data;
	}
}

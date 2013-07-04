package br.com.compraevenda.modelo;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="imagem")
public class Imagem {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int idimagem;
	
	@ManyToOne
	private Produto produto;
	
	private String urlImagem;	
	
	public Imagem() {
		urlImagem = "produtoDefault.jpg";
	}

	public String getUrlImagem() {
		return urlImagem;
	}

	public void setUrlImagem(String urlImagem) {
		this.urlImagem = urlImagem;
	}	

	public int getIdimagem() {
		return idimagem;
	}

	public void setIdimagem(int idimagem) {
		this.idimagem = idimagem;
	}	

	public Produto getProduto() {
		return produto;
	}

	public void setProduto(Produto produto) {
		this.produto = produto;
	}
	
	public boolean isFoto(){
		return "produtoDefault.jpg".equals(urlImagem) ? false : true;
	}
	
	
}

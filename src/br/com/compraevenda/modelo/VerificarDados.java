package br.com.compraevenda.modelo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="verificardados")
public class VerificarDados {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int idVerificarDados;
	
	@Column(length=10)
	private String tipoTabela;
	
	@Column(length=10)
	private String tipoComando;
	
	private int idTabela;
	
	@Column(length=5)
	private String statusVerificacao;	
	
	public VerificarDados(){}	
	
	public String getTipoComando() {
		return tipoComando;
	}
	
	public void setTipoComando(String tipoComando) {
		this.tipoComando = tipoComando;
	}
	
	public int getIdVerificarDados() {
		return idVerificarDados;
	}

	public void setIdVerificarDados(int idVerificarDados) {
		this.idVerificarDados = idVerificarDados;
	}

	public String getTipoTabela() {
		return tipoTabela;
	}

	public void setTipoTabela(String tipoTabela) {
		this.tipoTabela = tipoTabela;
	}

	public int getIdTabela() {
		return idTabela;
	}

	public void setIdTabela(int idTabela) {
		this.idTabela = idTabela;
	}

	public String getStatusVerificacao() {
		return statusVerificacao;
	}

	public void setStatusVerificacao(String statusVerificacao) {
		this.statusVerificacao = statusVerificacao;
	}
}

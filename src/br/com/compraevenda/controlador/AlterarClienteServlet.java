package br.com.compraevenda.controlador;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.regex.Pattern;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.hibernate.Session;

import br.com.compraevenda.dao.ClienteDAO;
import br.com.compraevenda.dao.RedeSocialDAO;
import br.com.compraevenda.modelo.Cliente;
import br.com.compraevenda.modelo.RedeSocial;
import br.com.compraevenda.util.ImagemUtil;

public class AlterarClienteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		HttpSession sessao = request.getSession();
		Cliente clienteSessao = (Cliente) sessao.getAttribute("cliente");

		boolean paginaComErro = false;
		boolean novoArquivoUpado = false;
		boolean removerTelefone = false;
		boolean removerEndereco = false;
		boolean removerOrkut = false;
		boolean removerFacebook = false;
		boolean removerTwitter = false;
		boolean removerFoto = false;
		Cliente cliente = new Cliente();
		cliente.setRedeSocial(new RedeSocial());
		String senha2 = "";
		cliente.setUrlImagem("fotoDefault.jpg");
		InputStream streamDaImagem = null;
		String nomeDoArquivo = "";

		Session hibernateSession = (Session)request.getAttribute("session");
		ClienteDAO dao = new ClienteDAO(hibernateSession);
		RedeSocialDAO redeSociaDao = new RedeSocialDAO(hibernateSession);

		boolean isMultipart = ServletFileUpload.isMultipartContent(request);

		if (isMultipart) {

			FileItemFactory fact = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(fact);
			List<FileItem> items = null;

			try {
				items = (List<FileItem>) upload.parseRequest(request);
			} catch (FileUploadException e) {
				e.printStackTrace();
			}

			for (FileItem item : items) {
				if (item.isFormField()) {
					if ("nome".equals(item.getFieldName())) {
						cliente.setNome(item.getString());
					} else if ("email".equals(item.getFieldName())) {
						cliente.setEmail(item.getString());
					} else if ("usuario".equals(item.getFieldName())) {
						cliente.setUsuario(item.getString());
					} else if ("senha".equals(item.getFieldName())) {
						cliente.setSenha(item.getString());
					} else if ("senha2".equals(item.getFieldName())) {
						senha2 = item.getString();
					} else if ("notificacao".equals(item.getFieldName())) {
						clienteSessao.setNotificacao(item.getString());
					} else if ("telefone".equals(item.getFieldName())) {
						cliente.setTelefone(item.getString());
					} else if ("removerTelefone".equals(item.getFieldName())){
						removerTelefone =  true;
					} else if ("autorizarTelefone".equals(item.getFieldName())) {
						clienteSessao.setAutorizarTelefone(Boolean.valueOf(item.getString()));
					} else if ("endereco".equals(item.getFieldName())) {
						cliente.setEndereco(item.getString());
					} else if ("removerEndereco".equals(item.getFieldName())){
						removerEndereco = true;
					} else if ("autorizarEndereco".equals(item.getFieldName())) {
						clienteSessao.setAutorizarEndereco(Boolean.valueOf(item.getString()));
					} else if ("cidade".equals(item.getFieldName())){
						cliente.setCidade(item.getString());
					} else if ("estado".equals(item.getFieldName())){						
						cliente.setEstado(item.getString());
					} else if ("orkut".equals(item.getFieldName())){
						cliente.getRedeSocial().setOrkut(item.getString());
					} else if ("facebook".equals(item.getFieldName())){
						cliente.getRedeSocial().setFacebook(item.getString());
					} else if ("twitter".equals(item.getFieldName())){
						cliente.getRedeSocial().setTwitter(item.getString());
					} else if ("removerFoto".equals(item.getFieldName())){
						removerFoto = true;
					} else if ("removerTwitter".equals(item.getFieldName())){
						removerTwitter = true;
					} else if ("removerFacebook".equals(item.getFieldName())){
						removerFacebook = true;
					} else if ("removerOrkut".equals(item.getFieldName())){
						removerOrkut = true;
					} 
				} else {
					try {
						nomeDoArquivo = item.getName();
						nomeDoArquivo = nomeDoArquivo.replaceAll(Pattern.quote("\\"), "");
						
						

						streamDaImagem = item.getInputStream();
						if (!nomeDoArquivo.isEmpty()) {
							novoArquivoUpado = true;
						}						
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}

		if (!cliente.getNome().isEmpty()) {
			clienteSessao.setNome(cliente.getNome());
		}

		if (!cliente.getCidade().isEmpty()) {
			clienteSessao.setCidade(cliente.getCidade());
		}
		
		if (!cliente.getEstado().isEmpty()){
			clienteSessao.setEstado(cliente.getEstado());
		}

		if (!senhasConferem(cliente.getSenha(), senha2)) {
			request.setAttribute("msgSenha", true);
			paginaComErro = true;
		}

		if (novaSenha(clienteSessao.getSenha(), cliente.getSenha())) {
			clienteSessao.setSenha(cliente.getSenha());
		}

		if (removerEndereco) {
			clienteSessao.setEndereco("");
		} else {
			if (!cliente.getEndereco().isEmpty()) {
				clienteSessao.setEndereco(cliente.getEndereco());
			}
		}

		if (removerTelefone) {
			clienteSessao.setTelefone("");
		} else {
			if (!cliente.getTelefone().isEmpty()) {
				clienteSessao.setTelefone(cliente.getTelefone());
			}
		}

		if (removerOrkut) {			
			clienteSessao.getRedeSocial().setOrkut("");
		} else {			
			if (!cliente.getRedeSocial().getOrkut().isEmpty()) {
				clienteSessao.getRedeSocial().setOrkut(
						getRedeSocialNoFormato(cliente.getRedeSocial()
								.getOrkut()));				
			}
		}

		if (removerFacebook) {			
			clienteSessao.getRedeSocial().setFacebook("");
		} else {
			if (!cliente.getRedeSocial().getFacebook().isEmpty()) {
				clienteSessao.getRedeSocial().setFacebook(
						getRedeSocialNoFormato(cliente.getRedeSocial()
								.getFacebook()));
			}
		}

		if (removerTwitter) {			
			clienteSessao.getRedeSocial().setTwitter("");
		} else {
			if (!cliente.getRedeSocial().getTwitter().isEmpty()) {
				clienteSessao.getRedeSocial().setTwitter(
						getRedeSocialNoFormato(cliente.getRedeSocial()
								.getTwitter()));
			}
		}

		if (novoArquivoUpado && !arquivoEhFoto(nomeDoArquivo)) {
			request.setAttribute("msgFoto", true);
			paginaComErro = true;
		}

		if (paginaComErro) {
			RequestDispatcher dispatcher = request
					.getRequestDispatcher("/alterarCliente.jsp");
			dispatcher.forward(request, response);
		} else {
			ImagemUtil imgUtil = new ImagemUtil();
			if (novoArquivoUpado) {
				if (cliente.isFoto()){
					imgUtil.deletarImagemDoservidor(clienteSessao.getUrlImagem());
				}

				clienteSessao.setUrlImagem(
						clienteSessao.getUsuario() + "_" + clienteSessao.getIdcliente() + "_"
						+ nomeDoArquivo);
				imgUtil.salvarImagemNoServidor(clienteSessao.getUrlImagem(),
						streamDaImagem);
			} else if (removerFoto){
				imgUtil.deletarImagemDoservidor(clienteSessao.getUrlImagem());
				clienteSessao.setUrlImagem("fotoDefault.jpg");
			}

			dao.atualizar(clienteSessao);
			redeSociaDao.atualizar(clienteSessao.getRedeSocial());

			HttpSession session = request.getSession();
			session.setAttribute("cliente", clienteSessao);

			request.setAttribute("clienteAlterado", true);

			RequestDispatcher dispatcher = request
					.getRequestDispatcher("/cliente.jsp");
			dispatcher.forward(request, response);
		}

	}

	private String getRedeSocialNoFormato(String redeSocial) {
		return (redeSocial.startsWith("http://")) ? redeSocial : "http://"
				+ redeSocial;
	}

	private boolean senhasConferem(String senha, String senha2) {
		return (senha.equals(senha2)) ? true : false;
	}

	private boolean novaSenha(String senhaAtual, String novaSenha) {
		return (!novaSenha.isEmpty() && !senhaAtual.equals(novaSenha)) ? true
				: false;
	}

	private boolean arquivoEhFoto(String nomeDoArquivo) {
		return (nomeDoArquivo.endsWith(".jpg")
				|| nomeDoArquivo.endsWith(".png")
				|| nomeDoArquivo.endsWith(".JPG") || nomeDoArquivo
				.endsWith(".PNG")) ? true : false;
	}
}

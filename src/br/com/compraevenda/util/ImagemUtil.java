package br.com.compraevenda.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

public class ImagemUtil {
	
	public static final String PRODUTO_DEFAULT = "produtoDefault.jpg";
	public static final String PESSOA_DEFAULT = "fotoDefault.jpg";

	public void salvarImagemNoServidor(String nomeDaFoto,
			InputStream streamDaImagem) {
		// TODO get class path
		try {
			String arquivo = "C:/workspaceGalileo/br.com.compraevenda/WebContent/imagem/"
					+ nomeDaFoto;

			File file = new File(arquivo);
			InputStream i = streamDaImagem;

			OutputStream outputStream = new FileOutputStream(file);
			int var;
			while ((var = i.read()) != -1) {
				outputStream.write(var);
			}
			i.close();
			outputStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void deletarImagemDoservidor(String urlImagem) {
		if (urlImagemDefault(urlImagem)) {
			throw new IllegalArgumentException(
					"Erro: impossivel deletar a imagem " + urlImagem);
		}
		
		System.out.println("deletar foto " + urlImagem);

		String arquivo = "C:/workspaceGalileo/br.com.compraevenda/WebContent/imagem/"
				+ urlImagem;
		File file = new File(arquivo);
		file.delete();
	}

	private boolean urlImagemDefault(String urlImagem) {
		return ("fotoDefault.jpg".equals(urlImagem) || "produtoDefault.jpg"
				.equals(urlImagem)) ? true : false;
	}
}

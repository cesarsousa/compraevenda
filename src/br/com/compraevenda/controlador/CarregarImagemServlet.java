package br.com.compraevenda.controlador;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CarregarImagemServlet
 */
public class CarregarImagemServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
	
	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// getServletContext().getRealPath("/");
		
		String arquivo;
        try {            
            arquivo = "C:/workspaceGalileo/br.com.compraevenda/WebContent/imagem/" + request.getParameter("id");
            File file = new File(arquivo);
            this.download( file.getName(), read( file ), response );
            
        } catch( IOException e ) {
            try {
                throw new IOException(e.getMessage());
            } catch (IOException ex) {
                ex.printStackTrace();
                throw new ServletException(e.getMessage() + " ::  Erro ao carregar arquivo");
            }
        }    
    }
	
	// Lê o arquivo no servidor
    private byte[] read( File file ) throws IOException {
        
        byte[] content = null;
        int fileLength = (int) file.length();
        FileInputStream fileInput = null;
        
        try {
            fileInput = new FileInputStream(file);
            
            BufferedInputStream bufferedInput = new BufferedInputStream(
                    fileInput);
            content = new byte[fileLength];
            bufferedInput.read(content, 0, fileLength);
            bufferedInput.close();
        } finally {
            if (fileInput != null) {
                fileInput.close();
            }
        }
        
        return content;
    }
    
    // Faz o download do arquivo
    private void download( String filename, byte[] content,
            HttpServletResponse response ) throws IOException {
        
        response.setContentType( "image/jpeg" );
        
        ServletOutputStream outStream = response.getOutputStream();        
        // envia o conteúdo do arquivo para o stream de resposta
        try {
            outStream.write( content );
            outStream.flush();
        } finally {
            outStream.close();
        }
    }
    
    // Passe para esse método um File com o arquivo desejado.
    @SuppressWarnings("unused")
	private void download( File file, HttpServletResponse response ) throws IOException {
        this.download( file.getName(), read( file ), response );
    }       
}
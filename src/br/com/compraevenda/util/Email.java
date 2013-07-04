package br.com.compraevenda.util;

import java.util.Date;

import javax.activation.DataHandler;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.NoSuchProviderException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import com.sun.mail.smtp.SMTPAddressFailedException;

/**
 * Classe utilitária para envio de emails.
 * 
 * @author cesar
 *
 */
public class Email {

	/**
	 * Envia um email utilizando o SMTP do Gmail.
	 * 
	 * @param emailOrigem
	 * @param senha
	 * @param emailDestino
	 * @param assunto
	 * @param mensagem
	 * @throws NoSuchProviderException
	 * @throws AddressException
	 * @throws MessagingException
	 * @throws SMTPAddressFailedException
	 */
	public static void enviarEmail(
			String emailOrigem, String senha, String emailDestino, String assunto, String mensagem)
			throws NoSuchProviderException, AddressException,
			MessagingException, SMTPAddressFailedException {

		java.util.Properties properties = new java.util.Properties();

		properties.put("mail.smtp.host", "smtp.gmail.com");
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.debug", "true");
		properties.put("mail.smtp.debug", "true");
		properties.put("mail.mime.charset", "ISO-8859-1");
		properties.put("mail.smtp.port", "465");
		properties.put("mail.smtp.starttls.enable", "true");
		properties.put("mail.smtp.socketFactory.port", "465");
		properties.put("mail.smtp.socketFactory.fallback", "false");
		properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		properties.put("mail.smtp.quitwait", "false");
		properties.setProperty("mail.transport.protocol", "smtp");

		Session session = Session.getInstance(properties, new Autenticacao(emailOrigem, senha));

		MimeMessage msg = new MimeMessage(session);
		MimeBodyPart mbp1 = new MimeBodyPart();
		Multipart multipart = new MimeMultipart();

		msg.setFrom(new InternetAddress(emailOrigem));
		msg.setRecipient(Message.RecipientType.TO, new InternetAddress(emailDestino));
		msg.setSubject(assunto);
		
		mbp1.setDataHandler(new DataHandler(mensagem, "text/html"));

		multipart.addBodyPart(mbp1);
		msg.setHeader("X-Mailer", "smtpsend");
		msg.setSentDate(new Date());
		msg.setContent(multipart);
		Transport.send(msg);
	}
}

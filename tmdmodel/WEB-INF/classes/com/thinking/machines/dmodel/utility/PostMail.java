package com.thinking.machines.dmodel.utility;
import javax.mail.*;
import javax.mail.internet.*;
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import java.util.Properties;
public class PostMail 
{
public void postMail(String from,String to[],String subject,String messageToSend) 
{
try
{
Properties props = new Properties();
props.put("mail.smtp.starttls.enable","true");
props.put("mail.transport.protocol", "smtp");
//Before hosting the webapplication, change
//the smtp.localhost to your mail accounts smtp host name
props.put("mail.smtp.host", "localhost"); 
props.put("mail.smtp.auth", "true");
Authenticator auth = new SMTPAuthenticator();
Session mailSession = Session.getDefaultInstance(props, auth);
// uncomment for debugging infos to stdout
// mailSession.setDebug(true);

Transport transport = mailSession.getTransport();
MimeMessage message = new MimeMessage(mailSession);
message.setContent(messageToSend, "text/html");
message.setFrom(new InternetAddress(from));
message.setSubject(subject);
for(int e=0;e<to.length;e++)
{
message.addRecipient(Message.RecipientType.TO,
new InternetAddress(to[e]));
}
transport.connect();
transport.sendMessage(message,
message.getRecipients(Message.RecipientType.TO));
transport.close();
}catch(Exception exception)
{
System.out.println(exception);
}
}
private class SMTPAuthenticator extends javax.mail.Authenticator 
{
public PasswordAuthentication getPasswordAuthentication() 
{
return new PasswordAuthentication("admin@somemail.com", "$$Ritesh$$");
}
}

}
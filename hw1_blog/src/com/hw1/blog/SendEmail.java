package com.hw1.blog;

import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;

public class SendEmail
{
     
      // Recipient's email ID needs to be mentioned.
      //String to = "ericmaras@gmail.com";

      // Sender's email ID needs to be mentioned
      String from = "ericmaras@gmail.com";

      // Assuming you are sending email from localhost
      String host = "localhost";

      // Get system properties
      Properties properties = System.getProperties();

      // Setup mail server
      public void send(String[] addresses_str){
	      properties.setProperty("mail.smtp.host", host);
	      
	      // Get the default Session object.
	      Session session = Session.getDefaultInstance(properties);
	
	      try{
	    	  Address[] addresses = new Address[addresses_str.length];
		      for(int i = 0; i < addresses_str.length; i++){
		    	  addresses[i] = new InternetAddress(addresses_str[i]);
		      }
	         // Create a default MimeMessage object.
	         MimeMessage message = new MimeMessage(session);
	
	         // Set From: header field of the header.
	         message.setFrom(new InternetAddress(from));
	
	         // Set To: header field of the header.
	         //message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
	         message.addRecipients(Message.RecipientType.BCC, addresses);
	         // Set Subject: header field
	         message.setSubject("Daily Digest");
	
	         // Now set the actual message
	         message.setText("This is actual message");
	
	         // Send message
	         Transport.send(message);
	         System.out.println("Sent message successfully....");
	      }catch (MessagingException mex) {
	         mex.printStackTrace();
	      }
      }
      
      
}
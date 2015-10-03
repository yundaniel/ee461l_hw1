package com.hw1.blog;

import java.util.*;
import java.util.logging.Logger;

import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;

import com.googlecode.objectify.ObjectifyService;

public class SendEmail
{
	private static final Logger _logger = Logger.getLogger(CronServlet.class.getName());
      // Sender's email ID needs to be mentioned
      String from = "daniel.yun.tx@gmail.com";

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
		    	  _logger.info("Address: " + addresses_str[i]);
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
	         StringBuffer emailMessage = new StringBuffer("This is a digest of all the posts in the last 24 hours:\n");
	         
	         
	         List<Post> posts = ObjectifyService.ofy().load().type(Post.class).list(); /////////////Need to get an array of posts here!!!
	         Calendar cal = Calendar.getInstance(TimeZone.getTimeZone("US/Central"));
	         
	         cal.add(Calendar.DAY_OF_YEAR, -1);
	         Date date = cal.getTime();
	 		
	         for(Post post: posts){
	        	 if (date.before(post.getDate())){
	        		 emailMessage.append("Title: ");
	        		 emailMessage.append(post.getTitle());
	        		 emailMessage.append("<br/>");
	        		 emailMessage.append("Author: ");
	        		 emailMessage.append(post.getUser());
	        		 emailMessage.append("<br/>");
	        		 emailMessage.append(post.getContent());
	        		 emailMessage.append("<br/>");
	        		 emailMessage.append("<br/>");
	        	 }
	         }
	         message.setText(emailMessage.toString(), "CHARSET_UTF_8", "html");
	         
	
	         // Send message
	         Transport.send(message);
	         System.out.println("Sent message successfully....");
	      }catch (MessagingException mex) {
	         mex.printStackTrace();
	      }
      }
      
      
}
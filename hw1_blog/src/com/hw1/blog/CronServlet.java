package com.hw1.blog;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.logging.Logger;
import java.util.*;

import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import java.util.Date;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.ObjectifyService;

import static com.googlecode.objectify.ObjectifyService.ofy;

@SuppressWarnings("serial")
public class CronServlet extends HttpServlet {
private static final Logger _logger = Logger.getLogger(CronServlet.class.getName());

public void doGet(HttpServletRequest req, HttpServletResponse resp)throws IOException {
	
	SendEmail sender = new SendEmail();
	try {
		_logger.info("Cron Job has been executed");
		String to = "ericmaras@gmail.com";
		////////We need to store subscribers somewhere
		////ArrayList<String> subscribers = new ArrayList<>()
		
		
		//////////
		String[] addresses = {to};
		List<Post> posts = ObjectifyService.ofy().load().type(Post.class).list(); /////////////Need to get an array of posts here!!!
		Date date = new Date();
		
		UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();
        
        String title = req.getParameter("title");
        String content = req.getParameter("content");
        
	
		for (Post post : posts){
			if (date.after(post.getDate())){
				sender.send(addresses);
				break;
			}
		}
		
		
		
		//Put your logic here
		//BEGIN
		//END
	}
	catch (Exception ex) {
		//Log any exceptions in your Cron Job
	}
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException {
		doGet(req, resp);
	}
}

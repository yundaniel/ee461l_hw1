package com.hw1.blog;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import com.googlecode.objectify.ObjectifyService;
import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class BlogPostServlet extends HttpServlet {
	
	static {
        ObjectifyService.register(Post.class);
    }
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
                throws IOException {
		
		UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();
        
        String title = req.getParameter("title");
        String content = req.getParameter("content");
        Post post = new Post(user, title, content);
 
        ofy().save().entity(post).now();   // synchronous
 
        resp.sendRedirect("/blog.jsp");
    }
}
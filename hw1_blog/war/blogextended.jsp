<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.hw1.blog.BlogPostServlet" %>
<%@ page import="com.hw1.blog.Post" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.googlecode.objectify.*" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
  <head>
    <link type="text/css" rel="stylesheet" href="/stylesheets/bootstrap.css" />
  </head>

  <body>
    
<%
    String blogName = request.getParameter("blogName");
    if (blogName == null) {
        blogName = "default";
    }
    pageContext.setAttribute("blogName", blogName);
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    if (user != null) {
      pageContext.setAttribute("user", user);
%>
<p>Hello, ${fn:escapeXml(user.nickname)}! (You can
<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)</p>
<%
    } else {
%>
<p>Hello!
<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>
to make a post.</p>
<%
    }
%>

    <div class="blog-header">
        <h1 class="blog-title"><a href="/blog.jsp">Join the Dank Side</a></h1>
        <img src="img/harold.jpg" alt="Harold" style="width:400px;height:267px;">
        <p class="lead blog-description">The official blog of Eric Maras and Daniel Yun</p>
    </div>

<%
    ObjectifyService.register(Post.class);
    List<Post> posts = ObjectifyService.ofy().load().type(Post.class).list();
    Collections.sort(posts);
    
    if (posts.isEmpty()) {
        %>
        <p>No posts here :(</p>
        <%
    } else {
        for (Post Post : posts) {
            pageContext.setAttribute("Post_user", Post.getUser());
            pageContext.setAttribute("Post_title", Post.getTitle());
            pageContext.setAttribute("Post_content", Post.getContent());
            %>
            <blockquote>
                <h1>${fn:escapeXml(Post_title)}</h1>
                <p><b>Author: ${fn:escapeXml(Post_user.nickname)}</b></p>
                <p>${fn:escapeXml(Post_content)}</p>
            </blockquote>
            <%
        }
        %>
            <a href="/blog.jsp" style="text-decoration:none;color:black">
                <input class="btn" type="button" value="View less" />
            </a>
        <%
    }
%>

	<a href="/createpost.jsp" style="text-decoration:none;color:black">
        <input class="btn" type="button" value="New Post" />
    </a>

  </body>
</html>
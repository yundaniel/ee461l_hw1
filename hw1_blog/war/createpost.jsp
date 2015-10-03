<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.hw1.blog.BlogPostServlet" %>
<%@ page import="com.hw1.blog.SubscribeServlet" %>
<%@ page import="com.hw1.blog.Post" %>
<%@ page import="com.hw1.blog.Email" %>
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
    
    String email_str = user.getEmail();  
    ObjectifyService.register(Email.class);
    List<Email> emails = ObjectifyService.ofy().load().type(Email.class).list();
%>
<p>Hello, ${fn:escapeXml(user.nickname)}! (You can
<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)</p>
<form action="/subscribe" method="post">
<%
        if(!emails.contains(new Email(email_str))) {
%>
            <div><input class="btn" type="submit" value="Subscribe"/></div>
<%
        } else {
%>
            <div><input class="btn" type="submit" value="Unsubscribe"/></div>
<%
        }
%>
        </form>
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
     if (user != null) {
%>
    <form action="/blogpost" method="post">
      <div><textarea name="title" rows="1" cols="20" style="resize:none"></textarea></div>
      <br></br>
      <div><textarea name="content" rows="5" cols="60"></textarea></div>
      <div><input class="btn" type="submit" value="New Post"/></div>
      <input type="hidden" name="blogName" value="${fn:escapeXml(blogName)}"/>
    </form>
    <a href="/blog.jsp" style="text-decoration:none;color:black">
        <input class="btn" type="button" value="Cancel" />
    </a>
<%
     } else {
%>
<p>You must
<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>
to post.</p>
<%
     }
%>

  </body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.hw1.blog.BlogPostServlet" %>
<%@ page import="com.hw1.blog.Post" %>
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
<br></br>
<br></br>
<%
    }
%>

    <form action="/blogpost" method="post">
      <div><textarea name="title" rows="1" cols="20" style="resize:none"></textarea></div>
      <br></br>
      <div><textarea name="content" rows="5" cols="60"></textarea></div>
      <div><input type="submit" value="New Post"/></div>
      <input type="hidden" name="blogName" value="${fn:escapeXml(blogName)}"/>
    </form>

  </body>
</html>
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
            if (Post.getUser() == null) {
                %>
                <p>An anonymous person wrote:</p>
                <%
            } else {
                pageContext.setAttribute("Post_user", Post.getUser());
                %>
                <p><b>${fn:escapeXml(Post_user.nickname)}</b> wrote:</p>
                <%
            }
            pageContext.setAttribute("Post_title", Post.getTitle());
            pageContext.setAttribute("Post_content", Post.getContent());
            %>
            <blockquote>
                <h1>${fn:escapeXml(Post_title)}</h1>
                <p>${fn:escapeXml(Post_content)}</p>
            </blockquote>
            <%
        }
    }
%>

	<a href="/createpost.jsp">New Post</a>

  </body>
</html>
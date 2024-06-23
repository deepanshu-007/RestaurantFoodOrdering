<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="javax.servlet.http.*" %>
<%
    // Get the current session, if one exists
    HttpSession Session = request.getSession(false);
    if (Session != null) {
        // Invalidate the session to log out the user
        Session.invalidate();
    }
    // Redirect the user to the login page
    response.sendRedirect("login.jsp");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Logging out...</title>
</head>
<body>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.database.DbConnection" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*, java.util.*" %>

<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        con = DbConnection.takeConnection();
        String query = "SELECT * FROM User WHERE email=? AND password=?";
        ps = con.prepareStatement(query);

        ps.setString(1, email);
        ps.setString(2, password);

        rs = ps.executeQuery();

        if (rs.next()) {
            session.setAttribute("username", rs.getString("name"));
            session.setAttribute("email", email);
            response.sendRedirect("home.jsp");
        } else {
            request.setAttribute("loginError", "Invalid email or password.");
            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("error.jsp");
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>


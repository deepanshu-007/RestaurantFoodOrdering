<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.database.DbConnection" %>
<%
    String itemId = request.getParameter("itemId");
    Connection con = null;
    PreparedStatement ps = null;

    try {
        con = DbConnection.takeConnection();
        String query = "DELETE FROM CartItem WHERE id = ?";
        ps = con.prepareStatement(query);
        ps.setInt(1, Integer.parseInt(itemId));
        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
    }

   
    response.sendRedirect("cart.jsp");
%>

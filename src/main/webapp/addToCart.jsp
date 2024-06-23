<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.database.DbConnection" %>
<%
    String foodItemId = request.getParameter("foodItemId");
    String quantity = request.getParameter("quantity");
    String userEmail = (String) session.getAttribute("email");
    

    if (userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection con = null;
    PreparedStatement ps = null;

    try {
        con = DbConnection.takeConnection();
        String query = "INSERT INTO CartItem (user_email, food_item_id, quantity) VALUES (?, ?, ?)";
        ps = con.prepareStatement(query);
        ps.setString(1, userEmail);
        ps.setString(2, foodItemId);
        ps.setString(3, quantity);
        ps.executeUpdate();
        response.sendRedirect("cart.jsp");
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

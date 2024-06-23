<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="com.database.DbConnection" %>
<%
    String userEmail = (String) session.getAttribute("email");

    if (userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    List<Map<String, String>> cartItems = new ArrayList<>();

    try {
        con = DbConnection.takeConnection();
        String query = "SELECT ci.id, ci.quantity, fi.name, fi.price FROM CartItem ci JOIN FoodItem fi ON ci.food_item_id = fi.id WHERE ci.user_email = ?";
        ps = con.prepareStatement(query);
        ps.setString(1, userEmail);
        rs = ps.executeQuery();

        while (rs.next()) {
            Map<String, String> cartItem = new HashMap<>();
            cartItem.put("id", rs.getString("id"));
            cartItem.put("name", rs.getString("name"));
            cartItem.put("price", rs.getString("price"));
            cartItem.put("quantity", rs.getString("quantity"));
            cartItems.add(cartItem);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: auto;
        }
        .cart-item {
            background-color: #fff;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .item-details {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
        .item-name {
            font-size: 18px;
            font-weight: bold;
        }
        .item-price {
            font-size: 16px;
            color: #888;
        }
        .item-quantity {
            font-size: 16px;
        }
        .total-price {
            font-size: 20px;
            font-weight: bold;
            margin-top: 10px;
        }
        .action-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
        }
        .update-button, .remove-button {
            padding: 8px 15px;
            cursor: pointer;
            border: none;
            border-radius: 3px;
            transition: background-color 0.3s;
        }
        .update-button {
            background-color: #4caf50;
            color: #fff;
        }
        .remove-button {
            background-color: #ff6b6b;
            color: #fff;
        }
        .update-button:hover, .remove-button:hover {
            background-color: #ddd;
        }
    </style>
     <%@include file ="include/head.jsp" %>
</head>
<body>
<%@include file ="include/navbar.jsp" %>
    <div class="container">
        <h3>Shopping Cart</h3>
        <% if (cartItems.isEmpty()) { %>
            <p>Your cart is empty.</p>
        <% } else { %>
            <% 
                double grandTotal = 0;
                for (Map<String, String> cartItem : cartItems) {
                    double price = Double.parseDouble(cartItem.get("price"));
                    int quantity = Integer.parseInt(cartItem.get("quantity"));
                    double total = price * quantity;
                    grandTotal += total;
            %>
            <div class="cart-item">
                <div class="item-details">
                    <div class="item-name"><%= cartItem.get("name") %></div>
                    <div class="item-price">$<%= price %></div>
                </div>
                <div class="item-quantity">
                    Quantity: 
                    <form action="updateQuantity.jsp" method="post">
                        <input type="hidden" name="itemId" value="<%= cartItem.get("id") %>">
                        <input type="number" name="quantity" value="<%= quantity %>" min="1">
                        <button class="update-button" type="submit">Update</button>
                    </form>
                </div>
                <div class="total-price">Total: $<%= total %></div>
                <div class="action-buttons">
                    <form action="removeItem.jsp" method="post">
                        <input type="hidden" name="itemId" value="<%= cartItem.get("id") %>">
                        <button class="remove-button" type="submit">Remove</button>
                    </form>
                </div>
            </div>
            <% } %>
            <div class="total-price">Grand Total: $<%= grandTotal %></div>
        <% } %>
    </div>
     <%@include file ="include/footer.jsp" %>
</body>
</html>

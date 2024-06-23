<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="com.database.DbConnection" %>
<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    List<Map<String, String>> foodItems = new ArrayList<>();

    try {
        con = DbConnection.takeConnection();
        String query = "SELECT * FROM FoodItem";
        ps = con.prepareStatement(query);
        rs = ps.executeQuery();

        while (rs.next()) {
            Map<String, String> foodItem = new HashMap<>();
            foodItem.put("id", rs.getString("id"));
            foodItem.put("name", rs.getString("name"));
            foodItem.put("description", rs.getString("description"));
            foodItem.put("price", rs.getString("price"));
            foodItem.put("image_url", rs.getString("image_url"));
            foodItems.add(foodItem);
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
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Food Items</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        .container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
        }
        .food-item {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 10px;
            margin: 10px;
            background-color: #fff;
            width: 220px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            text-align: center;
        }
        .food-item img {
            width: 100%;
            height: auto;
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
            margin-bottom: 10px;
        }
        .food-item h3 {
            font-size: 1.2em;
            margin: 0 0 10px;
        }
        .food-item p {
            font-size: 0.9em;
            color: #555;
            margin: 0 0 10px;
        }
        .food-item .price {
            font-size: 1.1em;
            color: #000;
            margin: 0 0 10px;
        }
        .food-item form {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .food-item input[type="number"] {
            width: 50px;
        }
        .food-item input[type="submit"] {
            background-color: #28a745;
            color: #fff;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 5px;
        }
        .food-item input[type="submit"]: hover {
            background-color: #218838;
        }
    </style>
    <%@include file ="include/head.jsp" %>
</head>
<body>
<%@include file ="include/navbar.jsp" %>
    <div class="container">
        <%
            for (Map<String, String> foodItem : foodItems) {
        %>
            <div class="food-item">
                <img src="<%= foodItem.get("image_url") %>" alt="<%= foodItem.get("name") %>">
                <h3><%= foodItem.get("name") %></h3>
                <p><%= foodItem.get("description") %></p>
                <p class="price">$<%= foodItem.get("price") %></p>
                <form action="addToCart.jsp" method="post">
                    <input type="hidden" name="foodItemId" value="<%= foodItem.get("id") %>">
                    <input type="number" name="quantity" value="1" min="1">
                    <input type="submit" value="Add to Cart">
                </form>
            </div>
        <%
            }
        %>
    </div>
    <%@include file ="include/footer.jsp" %>
</body>
</html>

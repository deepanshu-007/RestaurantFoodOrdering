<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<link rel='stylesheet' type="text/css" href='style.css'>
</head>
<body>
<div class="wrapper">
<h1>Login</h1>
 <%
            String loginError = (String) request.getAttribute("loginError");
            if (loginError != null) {
        %>
        <p style="color: red; text-align: center;"><%= loginError %></p>
        <%
            }
 %>
<form action="checklogin.jsp" method="post">
<div class = "input_box">
<input type="text" placeholder = "Email" required name="email"/>
<i class='bx bxs-user'></i>
</div>
<div class = "input_box">
<input type="password" placeholder = "Password" required name="password"/>
<i class='bx bxs-lock-alt'></i>
</div>
<button type="submit" class="btn">Login</button>
<div class="register_link">
<p>Don't have an account? <a href="register.jsp">Register</a></p>

</div>
</form>
</div>
</body>
</html>
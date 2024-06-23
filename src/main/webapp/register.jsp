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
<h1>Register</h1>
<form action="insertdata.jsp" method="post">
<div class = "input_box">
<input type="text" placeholder = "Enter Your Name" required name="name"/>
<i class='bx bxs-user'></i>
</div>
<div class = "input_box">
<input type="text" placeholder = "Enter Your Address" required name="address"/>
<i class='bx bxs-home'></i>
</div>
<div class = "input_box">
<input type="text" placeholder = "Enter Your Email" required name="email"/>
<i class='bx bxl-gmail' ></i>
</div>
<div class = "input_box">
<input type="password" placeholder = "Password" pattern=".{6,}" title="6 characters minimum"required name="password"/>
<i class='bx bxs-lock-alt'></i>
</div>
<button type="submit" class="btn">Register</button>
<div class="register_link">
<p>Already have an account! <a href="login.jsp">Login</a></p>

</div>
</form>
</div>
</body>
</html>
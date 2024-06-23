<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.database.DbConnection" %>
<%
    String name = request.getParameter("name");
	String address = request.getParameter("address");
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	int status = DbConnection.insertData(name, address, email, password);
	if(status>0){
		response.sendRedirect("login.jsp");
	}else{
		out.print("some error occured");
	}
%>
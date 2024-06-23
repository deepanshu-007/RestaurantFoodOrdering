package com.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class DbConnection {
	public static Connection takeConnection() {
		Connection con = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/myrestaurant","root","Deepanshu1608");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return con;
	}
	public static int insertData(String name , String address, String email, String password) {
		int status =0;
		try {
			Connection con = takeConnection();
           String query = "insert into User(name,address,email,password) values (?,?,?,?)";
           PreparedStatement ps = con.prepareStatement(query);
           ps.setString(1,name);
           ps.setString(2,address);
           ps.setString(3,email);
           ps.setString(4,password);
           status = ps.executeUpdate();     
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return status;
	}

}

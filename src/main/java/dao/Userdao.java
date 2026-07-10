package dao;

import java.sql.*;

import entity.User;

public class Userdao {
		//method1: Login authentification()
	
		public boolean checkLogin1(String uname,String upass) {
			try {
				Connection conn = DBconnection.getConnection();
				//3.create a statement object to execute sql statement 
				String sql ="Select * from users where username='"+uname + "' AND password='"+ upass+"'"; 
				//3.2 how to excute the sql statement 
				Statement stm = conn.createStatement();
				ResultSet rs = stm.executeQuery(sql);
				//3.3 handle the result 
				if(rs.next()== true) {
					stm.close();
					conn.close();
					return true;
				}else {
					return false;
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
			return false;
		}
		//method2: Login authentication -- from database and retrievee the permission
		public int checkLogin2(String uname,String upass) {
			try {
				//1. load and initiate the mysql driver
				Connection conn = DBconnection.getConnection();
				
				//3.create a statement object to execute sql statement 
				String sql ="Select * from users where username='"+uname + "' AND password='"+ upass+"'"; 
				//3.2 how to excute the sql statement 
				Statement stm = conn.createStatement();
				ResultSet rs = stm.executeQuery(sql);
				//3.3 handle the result 
				if (rs.next()) {
				    String auth = rs.getString("authority");
				    System.out.println("User found! Authority value = " + auth);  // ← add this
				    return Integer.parseInt(auth);
				} else {
				    System.out.println("No user found in DB");  // ← add this
				    return -1;
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
		public User checkLogin3(String uname,String upass) {
			try {
				Connection conn = DBconnection.getConnection();
				
				
				//3.create a statement object to execute sql statement 
				String sql ="Select * from users where username='"+uname + "' AND password='"+ upass+"'"; 
				//3.2 how to excute the sql statement 
				Statement stm = conn.createStatement();
				ResultSet rs = stm.executeQuery(sql);
				//3.3 handle the result 
				if(rs.next()== true) {
					User user1 =new User();
					user1.setUsername(rs.getString("username"));
					user1.setPassword(rs.getString("password"));
					user1.setEmail(rs.getString("email"));
					user1.setPhone(rs.getString("phone"));
					user1.setAge(rs.getInt("age"));
					user1.setAuthority(rs.getInt("authority"));
					
					
					return user1;
					
				}else {
					return null;
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
	// method 4 : create new account:insert user's information into user table
			
}

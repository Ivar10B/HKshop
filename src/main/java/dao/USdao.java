package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import entity.User;

public class USdao {
	 // Login 
		public static  boolean checklogin(String username,String password) {
			try {
				Connection conn = DBconnection.getConnection();
				String sql = "SELECT * FROM users WHERE username=? AND password=?";
				PreparedStatement ps= conn.prepareStatement(sql);
				ps.setString(1, username);
				ps.setString(2, password);
				ResultSet rs = ps.executeQuery();
				boolean found = rs.next();
				conn.close();
				return found;
			}catch (Exception e) {
				e.printStackTrace();	
			}
			return false;
		}
	 // Register: insert new user into DataBase
		public static boolean Newuser(User user) {
			 try {
				 	Connection conn = DBconnection.getConnection();
		            String sql = "INSERT INTO users	 (username, password,age, authority, email, phone) VALUES (?,?,?,?,?,?)";
		            PreparedStatement ps = conn.prepareStatement(sql);
		            ps.setString(1, user.getUsername());
		            ps.setString(2, user.getPassword());
		            ps.setInt(3, user.getAge());
		            ps.setInt(4, user.getAuthority());
		            ps.setString(5, user.getEmail());
		            ps.setString(6, user.getPhone());
		            ps.executeUpdate();
		            conn.close();
		            return true;
		        } catch (Exception e) {
		        	System.out.println("ERROR: " + e.getMessage());
		            e.printStackTrace();
		            return false;
		        }
		    }
	// get all user
		public static List<User> getAllUsers(){
			List<User> list = new ArrayList<User>();
			try {
			   Connection conn = DBconnection.getConnection();
		        String sql = "SELECT * FROM users";
		         PreparedStatement ps = conn.prepareStatement(sql);
		         ResultSet rs = ps.executeQuery();
		            while (rs.next()) {
		                User u = new User();
		                u.setUsername(rs.getString("username"));
		                u.setPassword(rs.getString("password"));
		                u.setAuthority(rs.getInt("authority"));
		                u.setEmail(rs.getString("email"));
		                u.setPhone(rs.getString("phone"));
		                list.add(u);
		            }
		            conn.close();
		            return list;
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		        return null;
		    }
		
		// DELETE
	public static void deleteUser(String username) {
		try {
			  Connection conn = DBconnection.getConnection();
	            String sql = "DELETE FROM users WHERE username=?";
	            PreparedStatement ps = conn.prepareStatement(sql);
	            ps.setString(1, username);
	            ps.executeUpdate();
	            conn.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
		}
		
// Update 
	public static boolean update(User user) {
		try {
			Connection conn = DBconnection.getConnection();
			String sql = "Update users set password=? , age=?,authority=?,email=?,phone=? WHERE username=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			  ps.setString(1, user.getPassword());
		        ps.setInt(2, user.getAge());
		        ps.setInt(3, user.getAuthority());
		        ps.setString(4, user.getEmail());
		        ps.setString(5, user.getPhone());
		        ps.setString(6, user.getUsername());
		        int rows = ps.executeUpdate();
		        conn.close();
		        return rows >0;
		}catch (Exception e) {
	        e.printStackTrace();
	        return false;  
		}
	}
}
			
			


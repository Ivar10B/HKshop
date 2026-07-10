package DB;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import bean.User;
import dao.DBconnection;
public class Usdao {
	//Login method
	 // Login — returns User object with role, or null if not found
	//But after login, LoginServlet needs to know is this Admin or customer? to redirect to the right page. 
	//So login must return the User object (with role inside), not just boolean:
	
		public  User login(String uname, String upass) {
			try {
				Connection conn = DBconnection.getConnection();
				String sql = "SELECT * FROM users where username=? AND password=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1, uname);
				ps.setString(2, upass);
				ResultSet rs = ps.executeQuery();
				 if (rs.next()) {
				        User u = new User();
				        u.setId(rs.getInt("id"));
				        u.setUsername(rs.getString("username"));
				        u.setEmail(rs.getString("email"));
				        u.setRole(rs.getString("role"));
				        conn.close(); // ✅ close FIRST, then return
				        return u;
				 }
				 conn.close();  // ✅ also close when user not found
			}catch (Exception e){
				e.printStackTrace();
			}
			return null;
		}
	//register method 
		public boolean registenewuser(User user) {
			try {
				Connection conn = DBconnection.getConnection();
				String sql = "Insert into users (username,password,email,role) VALUES (?,?,?,?)";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1, user.getUsername());
				ps.setString(2, user.getPassword());
				ps.setString(3, user.getEmail());
				ps.setString(4, user.getRole());
				ps.executeUpdate();
				conn.close();
				return true;
			}catch (Exception e){
				System.out.println("ERROR: " + e.getMessage());
				e.printStackTrace();
			}
			return false;
		}
	// get all user 
		public List<User> getallusers(){
			List<User> list  = new ArrayList<User>();
			try {
				Connection conn = DBconnection.getConnection();
		        String sql = "SELECT * FROM users";
		        PreparedStatement ps = conn.prepareStatement(sql);
		        ResultSet rs = ps.executeQuery();
	            while (rs.next()) {
	            	User u = new User();
	            	u.setId(rs.getInt("id"));
	            	u.setUsername(rs.getString("username"));
	            	u.setPassword(rs.getString("password"));
	            	u.setEmail(rs.getString("email"));
	            	u.setRole(rs.getString("role"));
	            	list.add(u);
	            }
	            conn.close();
	            
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
			return list; // ✅ return empty list not null
	    }
	// Update method 
		public void update(String uname,String upass,String uemail,String urole) {
	         try {
	        	Connection conn = DBconnection.getConnection();
	 	        String sql = "Update users SET password=?,email=?,role=? WHERE username=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,upass);
				ps.setString(2,uemail);
				ps.setString(3, urole);
				ps.setString(4, uname);
				ps.executeUpdate();
				conn.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	// DELETE method 
		public void delete(String uname) {
	         try {
	        	 Connection conn = DBconnection.getConnection();
	 	        String sql = "DELETE FROM users WHERE username=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1, uname);
				ps.executeUpdate();
	            conn.close();
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
		}
		
	// get username
		public User getUserName(String username) {
			try {
				Connection conn = DBconnection.getConnection();
		        String sql = "SELECT * FROM users WHERE username = ?";
		        PreparedStatement ps = conn.prepareStatement(sql);
		        ps.setString(1, username);
		        ResultSet rs = ps.executeQuery();
		        if(rs.next()) {
		        	User u = new User();
		        	u.setId(rs.getInt("id"));
		        	u.setUsername(rs.getString("username"));
		        	u.setPassword(rs.getString("password"));
		        	u.setEmail(rs.getString("email"));
		        	u.setRole(rs.getString("role"));
		        	conn.close();
		        	return u;
		        }
		        conn.close();
			}catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}


}
		


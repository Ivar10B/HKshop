package DB;

import java.util.List;
import java.sql.*;
import java.util.ArrayList;
import bean.products;
import dao.DBconnection;

public class Productdao {
	public List<products> getAll(){
		List<products> list  = new ArrayList<products>();
		try {
			Connection conn = DBconnection.getConnection();
	        String sql = "SELECT * FROM products";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ResultSet rs = ps.executeQuery();
            while(rs.next()){
            	products p = new products();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getDouble("price"));
                p.setDescription(rs.getString("description"));
                p.setQuantity(rs.getInt("quantity")); // ✅ read from DB
                p.setImage(rs.getString("image")); // ✅ add this
                list.add(p);
            }
            conn.close();
		}catch (Exception e) {
			System.out.println("ERROR: " + e.getMessage());
            e.printStackTrace();
		}
		return list;
	}
	public void updateQuantity(int pid, int qty) {
	    try {
	        Connection conn = DBconnection.getConnection();
	        String sql = "UPDATE products SET quantity = ? WHERE id = ?";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, qty);
	        ps.setInt(2, pid);
	        ps.executeUpdate();
	        conn.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
	public void deleteProduct(int pid) {
	    try {
	        Connection conn = DBconnection.getConnection();
	        String sql = "DELETE FROM products WHERE id = ?";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, pid);
	        ps.executeUpdate();
	        conn.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
	public void addProduct(products p) {
	    try {
	        Connection conn = DBconnection.getConnection();
	        String sql = "INSERT INTO products (name, price, description, quantity,image) "
	                   + "VALUES (?, ?, ?, ?,?)";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setString(1, p.getName());
	        ps.setDouble(2, p.getPrice());
	        ps.setString(3, p.getDescription());
	        ps.setInt(4, p.getQuantity());
	        ps.setString(5, p.getImage());
	        ps.executeUpdate();
	        conn.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
	
}

package DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import bean.CartItem;
import bean.CustomerInfo;
import bean.Order;
import bean.OrderItem;
import bean.OrderReport;
import dao.DBconnection;

public class OrderDao {
		
	public void saveCustomerInfo(CustomerInfo ci) {
	    try {
	        Connection conn = DBconnection.getConnection();

	        // check if customer info already exists for this user
	        String checkSql = "SELECT id FROM customer_info WHERE user_id = ?";
	        PreparedStatement checkPs = conn.prepareStatement(checkSql);
	        checkPs.setInt(1, ci.getUserId());
	        ResultSet rs = checkPs.executeQuery();

	        if (rs.next()) {
	            // ✅ already exists → UPDATE
	            String sql = "UPDATE customer_info SET first_name=?, last_name=?, " +
	                        "city=?, address=? WHERE user_id=?";
	            PreparedStatement ps = conn.prepareStatement(sql);
	            ps.setString(1, ci.getFirstName());
	            ps.setString(2, ci.getLastName());
	            ps.setString(3, ci.getCity());
	            ps.setString(4, ci.getAddress());
	            ps.setInt(5, ci.getUserId());
	            ps.executeUpdate();
	        } else {
	            // ✅ doesn't exist → INSERT
	            String sql = "INSERT INTO customer_info (user_id, first_name, last_name, city, address) " +
	                        "VALUES (?, ?, ?, ?, ?)";
	            PreparedStatement ps = conn.prepareStatement(sql);
	            ps.setInt(1, ci.getUserId());
	            ps.setString(2, ci.getFirstName());
	            ps.setString(3, ci.getLastName());
	            ps.setString(4, ci.getCity());
	            ps.setString(5, ci.getAddress());
	            ps.executeUpdate();
	        }
	        conn.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
	
	public int saveOrder(Order o) {
			try {
				Connection conn = DBconnection.getConnection();
				String sql = "INSERT INTO orders (user_id,payment_method,total_amount,order_date) VALUES(?,?,?,?)";
				// special JDBC pattern to get generated id
				PreparedStatement ps = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS); // ← tell JDBC to keep the id
				ps.setInt(1,o.getUserId());
				ps.setString(2,o.getPaymentMethod());
				ps.setDouble(3,o.getTotalAmount());
				ps.setString(4,o.getOrderdate());
				ps.executeUpdate();
				ResultSet rs = ps.getGeneratedKeys();// get the generated id
				if(rs.next()) {
					int id =rs.getInt(1);
					conn.close();
					return id; // ← return the new order id
				}
				
		}catch (Exception e){
			System.out.println("ERROR: " + e.getMessage());
			e.printStackTrace();
		}
			return -1;
	}
	public void saveorderItems(ArrayList<CartItem> cart,int orderInt) {
		 String sql = "INSERT INTO order_items(order_id,product_id,quantity,price) VALUES(?,?,?,?)";
		 try {
			 	Connection conn = DBconnection.getConnection();
			 	PreparedStatement ps =conn.prepareStatement(sql);
			 	for(int i =0;i<cart.size();i++) {
			 		CartItem item = cart.get(i); // get item first
			 		ps.setInt(1, orderInt);
			 		ps.setInt(2,item.getProduct().getId()); // product id
			 		ps.setInt(3,item.getQuantity());
			 		ps.setDouble(4,item.getTotalPrice()); 
			 		ps.executeUpdate(); // inside loop,one row per item
			 	}
			 	conn.close();
		 }catch (Exception e){
				System.out.println("ERROR: " + e.getMessage());
				e.printStackTrace();
			}
	}
	public void reduceQuantity(int productId,int qty) {
		try {
			Connection conn = DBconnection.getConnection();
			String sql = "UPDATE products set quantity= quantity -? WHERE id =? AND quantity >=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, qty);
			ps.setInt(2,productId);
			ps.setInt(3, qty);
			int updated = ps.executeUpdate();
			if(updated ==0) {
				// not enough stock 
				System.out.println("Not enough stock for product id: " + productId);
			}
			conn.close();
	}catch (Exception e){
		System.out.println("ERROR: " + e.getMessage());
		e.printStackTrace();
	}
	}
	public ArrayList<OrderItem> getOrderItems(int orderId){
		 ArrayList<OrderItem> list = new  ArrayList<OrderItem>();
		 try {
			 Connection conn = DBconnection.getConnection();
				String sql = "SELECT p.name,oi.quantity,oi.price from order_items oi JOIN products p ON oi.product_id = p.id WHERE oi.order_id=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setInt(1, orderId);
				ResultSet rs = ps.executeQuery();
				while(rs.next()) {
						OrderItem item = new OrderItem();
						item.setProductName(rs.getString("name"));
						item.setQuantity(rs.getInt("quantity"));
						item.setPrice(rs.getDouble("price"));
						list.add(item);
				}
				conn.close();
		 }catch(Exception e) {
			 e.printStackTrace();
		 }
		 return list;
	}
	public Order getOrder(int orderId) {
		try {
			Connection conn = DBconnection.getConnection();
			String sql = "SELECT * FROM orders Where id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, orderId);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				Order o = new Order();
				o.setId(rs.getInt("id"));
				o.setUserId(rs.getInt("user_id"));
				o.setPaymentMethod(rs.getString("payment_method"));
				o.setTotalAmount(rs.getDouble("total_amount"));
				o.setOrderdate(rs.getString("order_date"));
				 conn.close();
		         return o;
			}
			conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public CustomerInfo getCustomerInfo(int userId) {
		try {
			Connection conn = DBconnection.getConnection();
			String sql = "Select * from customer_info WHERE user_id = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				CustomerInfo ci = new CustomerInfo();
	            ci.setFirstName(rs.getString("first_name"));
	            ci.setLastName(rs.getString("last_name"));
	            ci.setCity(rs.getString("city"));
	            ci.setAddress(rs.getString("address"));
	            conn.close();
	            return ci;
			}
			conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
			return null;
	}
	public ArrayList<OrderReport> getAllOrders(){
			ArrayList<OrderReport> list = new ArrayList<OrderReport>();
			try {
				Connection conn = DBconnection.getConnection();
				String sql="SELECT o.id AS order_id,u.username,ci.first_name,ci.last_name,ci.city,o.payment_method,o.total_amount,o.order_date,p.name AS product_name,"
										+ "oi.quantity,oi.price FROM orders o "
										+ " JOIN users u ON o.user_id = u.id "
										+ " JOIN customer_info ci ON u.id = ci.user_id "
										+ " JOIN order_items oi ON o.id = oi.order_id "
										+ " JOIN products p ON oi.product_id = p.id  "
										+ " ORDER BY o.id DESC";
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while(rs.next()) {
					OrderReport r = new OrderReport();
					r.setOrderId(rs.getInt("order_id"));
					r.setUsername(rs.getString("username"));
					r.setFirstname(rs.getString("first_name"));
					r.setLastname(rs.getString("last_name"));
		            r.setCity(rs.getString("city"));
		            r.setPaymentMethod(rs.getString("payment_method"));
		            r.setTotalAmount(rs.getDouble("total_amount"));
		            r.setOrderDate(rs.getString("order_date"));
		            r.setProductName(rs.getString("product_name"));
		            r.setQuantity(rs.getInt("quantity"));
		            r.setPrice(rs.getDouble("price"));
		            list.add(r);;
				}
				conn.close();
			} catch (Exception e) {
		        e.printStackTrace();
		    }
			return list;					
			}	
	public ArrayList<OrderReport> getOrdersByUserId(int userId) {
	    ArrayList<OrderReport> list = new ArrayList<OrderReport>();
	    try {
	        Connection conn = DBconnection.getConnection();
	        String sql = "SELECT o.id AS order_id, u.username, " +
	                     "ci.first_name, ci.last_name, ci.city, " +
	                     "o.payment_method, o.total_amount, o.order_date, " +
	                     "p.name AS product_name, oi.quantity, oi.price " +
	                     "FROM orders o " +
	                     "JOIN users u ON o.user_id = u.id " +
	                     "JOIN customer_info ci ON u.id = ci.user_id " +
	                     "JOIN order_items oi ON o.id = oi.order_id " +
	                     "JOIN products p ON oi.product_id = p.id " +
	                     "WHERE o.user_id = ? " +  // ✅ only this user's orders
	                     "ORDER BY o.id DESC";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, userId);  // ✅ pass the user id
	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            OrderReport r = new OrderReport();
	            r.setOrderId(rs.getInt("order_id"));
	            r.setUsername(rs.getString("username"));
	            r.setFirstname(rs.getString("first_name"));
	            r.setLastname(rs.getString("last_name"));
	            r.setCity(rs.getString("city"));
	            r.setPaymentMethod(rs.getString("payment_method"));
	            r.setTotalAmount(rs.getDouble("total_amount"));
	            r.setOrderDate(rs.getString("order_date"));
	            r.setProductName(rs.getString("product_name"));
	            r.setQuantity(rs.getInt("quantity"));
	            r.setPrice(rs.getDouble("price"));
	            list.add(r);
	        }
	        conn.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}
	public ArrayList<OrderItem> getItemsByOrderId(int orderId) {
	    ArrayList<OrderItem> list = new ArrayList<OrderItem>();
	    try {
	        Connection conn = DBconnection.getConnection();
	        String sql = "SELECT * FROM order_items WHERE order_id = ?";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, orderId);
	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            OrderItem item = new OrderItem();
	            item.setProductId(rs.getInt("product_id"));
	            item.setQuantity(rs.getInt("quantity"));
	            list.add(item);
	        }
	        conn.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}
	
	public void deleteOrderItems(int orderId) {
	    try {
	        Connection conn = DBconnection.getConnection();
	        String sql = "DELETE FROM order_items WHERE order_id = ?";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, orderId);
	        ps.executeUpdate();
	        conn.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
	public void deleteOrder(int orderId) {
	    try {
	        Connection conn = DBconnection.getConnection();
	        String sql = "DELETE FROM orders WHERE id = ?";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, orderId);
	        ps.executeUpdate();
	        conn.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}public void restoreQuantity(int productId, int qty) {
	    try {
	        Connection conn = DBconnection.getConnection();
	        String sql = "UPDATE products SET quantity = quantity + ? WHERE id = ?";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, qty);
	        ps.setInt(2, productId);
	        ps.executeUpdate();
	        conn.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
	}

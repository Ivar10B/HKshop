package dao;
import java.sql.Connection;
import java.sql.DriverManager;
public class DBconnection {
	 private static final String url = "jdbc:mysql://localhost:3306/hkshop?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
	    private static final String USER     = "root";
	    private static final String PASSWORD = "123456789hamzaKH@";  
	    public static Connection getConnection() {
	        Connection conn = null;
	        try {
	            // Load the MySQL driver
	            Class.forName("com.mysql.jdbc.Driver");
	            // Open the connection
	            conn = DriverManager.getConnection(url, USER, PASSWORD);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return conn;
	    }
}	

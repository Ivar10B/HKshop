package dao;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class DBconnection {

    private static String URL;
    private static String USER;
    private static String PASSWORD;

    // This block runs ONCE when the class is first loaded
    // It reads db.properties and stores the values
    static {
        try {
            Properties props = new Properties();

            // Load db.properties from the classpath
            // getResourceAsStream looks inside src/main/java/dao/
            InputStream input = DBconnection.class
                .getClassLoader()
                .getResourceAsStream("dao/db.properties");

            // If file not found — stop immediately with clear error
            if (input == null) {
                throw new RuntimeException(
                    "db.properties not found. " +
                    "Copy db.properties.example to db.properties " +
                    "and fill in your credentials."
                );
            }

            // Read all key=value pairs from the file
            props.load(input);

            // Get each value by its key name
            URL      = props.getProperty("db.url");
            USER     = props.getProperty("db.username");
            PASSWORD = props.getProperty("db.password");

            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to load DB config: " + e.getMessage());
        }
    }

    public static Connection getConnection() throws Exception {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
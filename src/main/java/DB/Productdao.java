package DB;

import java.util.List;
import java.sql.*;
import java.util.ArrayList;
import bean.products;
import dao.DBconnection;

public class Productdao {

    // ── GET ALL PRODUCTS ─────────────────────────────────────────
    public List<products> getAll() {
        List<products> list = new ArrayList<>();
        String sql = "SELECT * FROM products";
        try (Connection conn = DBconnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                products p = new products();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getDouble("price"));
                p.setDescription(rs.getString("description"));
                p.setQuantity(rs.getInt("quantity"));
                p.setImage(rs.getString("image"));
                list.add(p);
            }
        } catch (Exception e) {
            System.out.println("ERROR: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    // ── UPDATE QUANTITY ──────────────────────────────────────────
    public void updateQuantity(int pid, int qty) {
        String sql = "UPDATE products SET quantity = ? WHERE id = ?";
        try (Connection conn = DBconnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, qty);
            ps.setInt(2, pid);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ── DELETE PRODUCT ───────────────────────────────────────────
    public void deleteProduct(int pid) {
        String sql = "DELETE FROM products WHERE id = ?";
        try (Connection conn = DBconnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, pid);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ── ADD PRODUCT ──────────────────────────────────────────────
    public void addProduct(products p) {
        String sql = "INSERT INTO products (name, price, description, quantity, image) "
                   + "VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBconnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, p.getName());
            ps.setDouble(2, p.getPrice());
            ps.setString(3, p.getDescription());
            ps.setInt(4, p.getQuantity());
            ps.setString(5, p.getImage());
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
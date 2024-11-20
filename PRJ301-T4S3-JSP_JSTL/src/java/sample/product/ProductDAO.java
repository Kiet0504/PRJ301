package sample.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import sample.utils.DBUtils;

public class ProductDAO {

    private static final String SHOPPING = "SELECT productID, name, price, quantity, status FROM tbl_Products";
    private static final String SEARCH = "SELECT productID, name, price, quantity, status FROM tbl_Products WHERE name LIKE ?";
    private static final String GET_QUANTITY = "SELECT quantity FROM tbl_Products WHERE productID = ?";
    private static final String ADD = "INSERT INTO tbl_Products(productID, name, price, quantity) VALUES(?, ?, ?, ?)";
    private static final String DELETE = "DELETE tbl_Products WHERE productID=?";

    public List<Product> getProductList() throws ClassNotFoundException, SQLException, NamingException {
        List<Product> listProduct = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SHOPPING);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String productID = rs.getString("productID");
                    String name = rs.getString("name");
                    double price = rs.getDouble("price");
                    int quantity = rs.getInt("quantity");
                    boolean status = rs.getBoolean("status");
                    listProduct.add(new Product(productID, name, price, quantity, status));
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listProduct;
    }

    public List<Product> getListProduct(String search) throws SQLException, ClassNotFoundException, NamingException {
        List<Product> listProduct = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH);
                ptm.setString(1, "%" + search + "%");
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String productID = rs.getString("productID");
                    String name = rs.getString("name");
                    double price = rs.getDouble("price");
                    int quantity = rs.getInt("quantity");
                    boolean status = rs.getBoolean("status");
                    listProduct.add(new Product(productID, name, price, quantity, status));
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listProduct;
    }

    public boolean updateProductQuantity(String productID, int quantity) throws SQLException, ClassNotFoundException, NamingException {
        boolean isUpdated = false;
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBUtils.getConnection();
            if (con != null) {
                String sql = "UPDATE tbl_Products SET quantity = quantity - ? WHERE productID = ?";
                ps = con.prepareStatement(sql);
                ps.setInt(1, quantity);
                ps.setString(2, productID);
                isUpdated = ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            throw new SQLException("Error updating product quantity: " + e.getMessage());
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return isUpdated;
    }

    public int getProductQuantity(String productID) throws SQLException, ClassNotFoundException, NamingException {
        int quantity = 0;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            if (con != null) {
                ps = con.prepareStatement(GET_QUANTITY);
                ps.setString(1, productID);
                rs = ps.executeQuery();
                if (rs.next()) {
                    quantity = rs.getInt("quantity");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error while fetching product quantity: " + e.getMessage());
            throw e;
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return quantity;
    }

    public boolean insertProduct(Product product) throws SQLException, ClassNotFoundException, NamingException {
        boolean isInserted = false;
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBUtils.getConnection();
            if (con != null) {
                ps = con.prepareStatement(ADD);
                ps.setString(1, product.getProductID());
                ps.setString(2, product.getName());
                ps.setDouble(3, product.getPrice());
                ps.setInt(4, product.getQuantity());
                isInserted = ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            throw new SQLException("Error inserting product: " + e.getMessage());
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return isInserted;
    }
}

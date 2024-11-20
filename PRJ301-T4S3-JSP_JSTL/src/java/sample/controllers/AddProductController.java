package sample.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sample.product.Product;
import sample.product.ProductDAO;
import sample.product.ProductError;

public class AddProductController extends HttpServlet {

    private static final String ERROR = "addProduct.jsp";
    private static final String SUCCESS = "addProduct.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        ProductError productError = new ProductError();
        boolean valid = true; 
        try {
            String productID = request.getParameter("productID");
            String name = request.getParameter("name");
            double price = 0;
            int quantity = 0;

            try {
                price = Double.parseDouble(request.getParameter("price"));
                if (price <= 0) {
                    productError.setPriceError("Price cannot be negative or zero");
                    valid = false;
                }
            } catch (NumberFormatException e) {
                productError.setPriceError("Price must be a valid number");
                valid = false;
            }

            try {
                quantity = Integer.parseInt(request.getParameter("quantity"));
                if (quantity <= 0) {
                    productError.setQuantityError("Quantity cannot be negative or zero");
                    valid = false;
                }
            } catch (NumberFormatException e) {
                productError.setQuantityError("Quantity must be a valid number");
                valid = false;
            }
            if (valid) {
                ProductDAO dao = new ProductDAO(); 
                Product product = new Product(productID, name, price, quantity, true);
                boolean checkInsert = dao.insertProduct(product);
                if (checkInsert) {
                    url = SUCCESS;
                    request.setAttribute("MESSAGE", "Added Product.");
                } else {
                    productError.setError("UNKNOWN_ERROR");
                    request.setAttribute("PRODUCT_ERROR", productError);
                }
            } else {
                request.setAttribute("PRODUCT_ERROR", productError);
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Internal server error.");
            log("Error at AddProductController: " + e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("addProduct.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "AddProductController";
    }
}

package sample.controllers;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.product.Cart;
import sample.product.Order;
import sample.product.OrderDAO;
import sample.product.Product;
import sample.product.OrderDetail;
import sample.product.ProductDAO;

public class CheckoutController extends HttpServlet {

    private static final String ERROR = "viewCart.jsp";
    private static final String SUCCESS = "checkout.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        boolean checkOrder = false;
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("CART");
            if (cart == null || cart.getCart().isEmpty()) {
                request.setAttribute("ERROR", "Your cart is empty.");
                request.getRequestDispatcher(ERROR).forward(request, response);
                return;
            }
            float total;
            try {
                total = Float.parseFloat(request.getParameter("total"));
            } catch (NumberFormatException e) {
                request.setAttribute("ERROR", "Invalid total amount.");
                request.getRequestDispatcher(ERROR).forward(request, response);
                return;
            }

            String userID = request.getParameter("userID");
            if (userID == null || userID.trim().isEmpty()) {
                request.setAttribute("ERROR", "Invalid user ID.");
                request.getRequestDispatcher(ERROR).forward(request, response);
                return;
            }

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String dateOrder = sdf.format(new Date());

            String orderID = UUID.randomUUID().toString();

            Order order = new Order(orderID, userID, total, dateOrder, 1);

            OrderDAO orderDAO = new OrderDAO();
            ProductDAO productDAO = new ProductDAO();

            for (Product product : cart.getCart().values()) {
                String productID = product.getProductID();
                int quantityInCart = product.getQuantity();
                int quantityInDB = productDAO.getProductQuantity(productID);

                if (quantityInCart > quantityInDB) {
                    request.setAttribute("ERROR", "Product " + product.getName() + " exceeds available quantity.");
                    request.getRequestDispatcher(ERROR).forward(request, response);
                    return;
                }
            }
            orderDAO.insertOrder(order);
            for (Product product : cart.getCart().values()) {
                String productID = product.getProductID();
                double price = product.getPrice();
                int quantity = product.getQuantity();
                OrderDetail orderDetail = new OrderDetail(orderID, productID, price, quantity, 1);
                checkOrder = orderDAO.insertOrderDetail(orderDetail);
                if (!checkOrder) {
                    break;
                }
                boolean isUpdated = productDAO.updateProductQuantity(productID, quantity);
                if (!isUpdated) {
                    checkOrder = false;
                    break;
                }
            }
            if (checkOrder) {
                session.removeAttribute("CART");
                try {
                    List<Order> orderHistory = orderDAO.getOrderHistory(userID);
                    session.setAttribute("ORDER_HISTORY", orderHistory);
                } catch (Exception e) {
                    log("Error retrieving order history: " + e.toString());
                    request.setAttribute("ERROR", "Error retrieving order history.");
                    request.getRequestDispatcher(ERROR).forward(request, response);
                    return;
                }
                url = SUCCESS;
                request.setAttribute("MESSAGE", "Thank You For Your Order");
            }

        } catch (Exception e) {
            log("Error at CheckoutController: " + e.toString());
            request.setAttribute("ERROR", "An error occurred during the checkout process.");
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Checkout Controller";
    }
}

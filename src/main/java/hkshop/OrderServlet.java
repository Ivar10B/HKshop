package hkshop;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import DB.OrderDao;
import bean.OrderItem;
import bean.User;

public class OrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Security check
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("user");
        if (u == null) {
            response.sendRedirect(request.getContextPath() + "/Hkshop/login1.jsp");
            return;
        }

        String action = request.getParameter("action");

        // 2. Delete order
        if ("delete".equals(action)) {

            int orderId = Integer.parseInt(request.getParameter("orderId"));

            OrderDao dao = new OrderDao();

            // Step 1 — get items first to restore quantity
            ArrayList<OrderItem> items = dao.getItemsByOrderId(orderId);

            // Step 2 — restore product quantity for each item
            for (int i = 0; i < items.size(); i++) {
                OrderItem item = items.get(i);
                dao.restoreQuantity(item.getProductId(), item.getQuantity());
            }

            // Step 3 — delete order items first (children)
            dao.deleteOrderItems(orderId);

            // Step 4 — delete order (parent)
            dao.deleteOrder(orderId);

            // Step 5 — redirect back
            response.sendRedirect(request.getContextPath() +
                "/Hkshop/myorders.jsp?success=1");
            return;
        }
    }
}
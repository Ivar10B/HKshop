package hkshop;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;

import DB.OrderDao;
import bean.CartItem;
import bean.CustomerInfo;
import bean.Order;
import bean.User;

/**
 * Servlet implementation class PaymentServlet
 */
public class PaymentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PaymentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
			String firstname = request.getParameter("firstName");
			String lastname = request.getParameter("lastName");
			String city = request.getParameter("city");
			String address = request.getParameter("address");
			String paymentmode = request.getParameter("paymentMethod");
			
			HttpSession session = request.getSession();
			ArrayList<CartItem> cart = (ArrayList<CartItem>) session.getAttribute("cart");
			User u = (User) session.getAttribute("user"); // in loginservlet we save it as user so we need to call it 
			// safety check 
			if(u== null || cart == null|| cart.size() ==0) {
					response.sendRedirect(request.getContextPath()+"/Hkshop/login1.jsp");
					return;
			}	
			// step 3: save customer info
			double gTotal =0;
			for(int i =0 ; i<cart.size();i++) {
				gTotal += cart.get(i).getTotalPrice();
			}
			CustomerInfo ci = new CustomerInfo();
			ci.setUserId(u.getId()); // user id from the users table 
			ci.setFirstName(firstname);
			ci.setLastName(lastname);
			ci.setCity(city);
			ci.setAddress(address);
		 
			OrderDao o = new OrderDao();
			// ✅ correct method name
			o.saveCustomerInfo(ci);
			//String 4 save order -> orders table -> get generated id 
			
			String orderDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
			
			Order order = new Order();
			order.setUserId(u.getId());
			order.setPaymentMethod(paymentmode);
			order.setTotalAmount(gTotal);
			order.setOrderdate(orderDate);
			
			int orderId = o.saveOrder(order);
			
			if(orderId == -1) {
				response.sendRedirect(request.getContextPath()+ "/Hkshop/checkout.jsp?error=1");
				return;
			}
			
			// step 5 save orderitems
			 o.saveorderItems(cart, orderId);
			 
			// step 6 reduce stock for each product
			 
			 for(int i =0;i<cart.size();i++) {
				 CartItem item = cart.get(i);
				 o.reduceQuantity(item.getProduct().getId(), item.getQuantity());
			 }
			// step 7 save orderid to sesion
			 session.setAttribute("lastOrderId", orderId);
			// remove cart from session — order is placed
			 session.removeAttribute("cart"); // Use removeAttribute not setAttribute(null) — cleaner way to delete from session.
			 
			 response.sendRedirect(request.getContextPath()+"/Hkshop/confirmation.jsp");

	}

}

package hkshop;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import DB.Productdao;
import bean.CartItem;
import bean.products;


public class Cartitemservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Cartitemservlet() {
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
		String action = request.getParameter("action");
			if("view".equals(action)) {
					response.sendRedirect(request.getContextPath()+ "/Hkshop/cart.jsp");
					return;
			}
			
			if("remove".equals(action)) {
				int removeid = Integer.parseInt(request.getParameter("productId"));
				HttpSession session = request.getSession();
				ArrayList<CartItem> cart = (ArrayList<CartItem>) session.getAttribute("cart");
				if(cart != null) {
					for(int i =0;i<cart.size();i++) {
						if(cart.get(i).getProduct().getId()== removeid) {
							cart.remove(i);
							break;
						}
					}
					session.setAttribute("cart", cart);
				}
				response.sendRedirect(request.getContextPath()+ "/Hkshop/cart.jsp");
				return;
			}
				
				
				
				
			//Read ProductId safely 	
			String id = request.getParameter("productId");
			if(id ==null) {
				response.sendRedirect("index.jsp");
				return;
			}
			
			
			int pid =Integer.parseInt(id);
			//Get all products from DB
			Productdao pdao = new Productdao();
			List<products> list = pdao.getAll();
			
			products found = null;
			//  Loop to find the product by id
				for(products p:list) {
					if(p.getId() == pid) {
							found =p;
							break;
					}
				}
				if (found == null) {
			        response.sendRedirect(request.getContextPath() + "/Hkshop/index.jsp");
			        return;
				}
			// get the session
			HttpSession session = request.getSession();
			//try to get existing cart
			ArrayList<CartItem> cart = (ArrayList<CartItem>) session.getAttribute("cart");
			
			if(cart == null) {
				cart = new ArrayList<CartItem>();
			}
			
		boolean found2 =false;
			for(int i =0;i<cart.size();i++) {
				CartItem item = cart.get(i);
				if(item.getProduct().getId()==pid) {
					// already in cart → increase quantity by 1
					item.setQuantity(item.getQuantity()+1);
					found2 = true; 
					break;
				}
			}
			 // ✅ Bug 2 fixed — add new item when not in cart
		    if (!found2) {
		        CartItem newItem = new CartItem(found, 1);
		        cart.add(newItem);
		    }
			session.setAttribute("cart", cart);
			response.sendRedirect(request.getContextPath() + "/Hkshop/index.jsp?success=1");
	}

}

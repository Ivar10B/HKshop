package hkshop;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import DB.Productdao;
import bean.User;
import bean.products;

/**
 * Servlet implementation class ProductServlet
 */
public class ProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductServlet() {
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
			HttpSession session = request.getSession();
			User u = (User) session.getAttribute("user");
			if (u == null || !u.getRole().equals("admin")) {
			    response.sendRedirect(request.getContextPath() + "/Hkshop/login1.jsp");
			    return;
			}
			String action = request.getParameter("action");
			if("add".equals(action)) {
			String name= request.getParameter("name");
			String description= request.getParameter("description");
			double price = Double.parseDouble(request.getParameter("price"));
			int quantity = Integer.parseInt(request.getParameter("quantity"));
			String image = request.getParameter("image");
			products product =new products ();
			product.setName(name);
			product.setPrice(price);
			product.setDescription(description);
			product.setQuantity(quantity);
			product.setImage(image);                       
			Productdao pdao = new Productdao();
			pdao.addProduct(product);
			response.sendRedirect(request.getContextPath() + "/Hkshop/Admin/products.jsp?success=1");
			return;
			}
			if("delete".equals(action)) {
				String id = request.getParameter("pid");
				int pid = Integer.parseInt(id);
				Productdao pdao = new Productdao();
				//we don't have a method called delete product in the Productdap.java
				pdao.deleteProduct(pid);
				response.sendRedirect(request.getContextPath() + "/Hkshop/Admin/products.jsp?success=2");
				return;
			}
			if("updateQty".equals(action)) {
				String id = request.getParameter("pid");
				int quantity = Integer.parseInt(request.getParameter("quantity"));
				int pid = Integer.parseInt(id);
				Productdao pdao = new Productdao();
				//we don't have a method called updateQtyproduct in the Productdap.java
				pdao.updateQuantity(pid,quantity);
				response.sendRedirect(request.getContextPath() + "/Hkshop/Admin/products.jsp?success=3");
				return;
			}
	}

}

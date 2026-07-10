package hkshop;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import DB.Usdao;
import bean.User;

/**
 *  implementation class AdminServlet
 */

public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminServlet() {
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
		HttpSession session = request.getSession();
		User u = (User) session.getAttribute("user");
		if (u == null || !u.getRole().equals("admin")) {
		    response.sendRedirect(request.getContextPath() + "/Hkshop/login1.jsp");
		    return;
		}
		String action = request.getParameter("action");
		String username = request.getParameter("username");
			if("delete".equals(action)) {
					Usdao odao = new Usdao();
					odao.delete(username);
					response.sendRedirect(request.getContextPath()+ "/Hkshop/Admin/users.jsp");
					return;
			}
			if("update".equals(action)) {
					String password = request.getParameter("password");
					String confirmpass = request.getParameter("confirmPassword");
					String email = request.getParameter("email");
					String role = request.getParameter("role");
					if (!password.equals(confirmpass)) {
						 response.sendRedirect(request.getContextPath() + "/Hkshop/Admin/editUser.jsp?username="+ username + "&error=1");
			             return ; 
					}
					Usdao o = new Usdao();
					o.update(username, password, email, role);
					response.sendRedirect(request.getContextPath() + "/Hkshop/Admin/users.jsp");
					return;
			}
	}

}

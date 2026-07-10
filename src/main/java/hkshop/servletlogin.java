package hkshop;

import java.io.IOException;

import DB.Usdao;
import bean.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class servletlogin
 */
public class servletlogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public servletlogin() {
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
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		Usdao dao = new Usdao();
		User u = dao.login(username, password);
		if( u == null) {
			// wrong password or username , go back to login page with an error 
			response.sendRedirect(request.getContextPath() + "/Hkshop/login1.jsp?error=1");
			return;
		}
			HttpSession session = request.getSession();
			session.setAttribute("user", u);
		if(u.getRole().equals("admin")) {
            response.sendRedirect(request.getContextPath() + "/Hkshop/Admin/dashboared.jsp");
		}else {
			response.sendRedirect(request.getContextPath() + "/Hkshop/index.jsp");
		}
	}

}

package hkshop;
import org.mindrot.jbcrypt.BCrypt;
import java.io.IOException;

import DB.Usdao;
import bean.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class registerservlet
 */

public class registerservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public registerservlet() {
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
		String plainPassword = request.getParameter("password");
		
		String confirmPassword = request.getParameter("confirmPassword");
		String email =request.getParameter("email");
		// checking password with the confirm password 
		 if (!plainPassword.equals(confirmPassword)) { 
			 response.sendRedirect(request.getContextPath() + "/Hkshop/register.jsp?error=1");
             return ; 
		}
		 	//hash the password
		 String hashedPassword = BCrypt.hashpw(plainPassword, BCrypt.gensalt());
		 // build new object 
		User u = new User();
		 u.setUsername(username);
		 u.setPassword(hashedPassword);
	     u.setEmail(email);
	     u.setRole("customer"); 
	     // Save to data base 
	     Usdao dao = new Usdao();
	     boolean ok = dao.registenewuser(u);
	     if(ok) {
	    	 response.sendRedirect(request.getContextPath() + "/Hkshop/login1.jsp?success=1");
	}else {
		response.sendRedirect(request.getContextPath() + "/Hkshop/register.jsp?error=2");
	}
}
}



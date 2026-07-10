package hkshop;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get the session
        HttpSession session = request.getSession(false);

        // 2. Destroy everything in session
        if (session != null) {
            session.invalidate();
        }

        // 3. Redirect to login page
        response.sendRedirect(request.getContextPath() + "/Hkshop/login1.jsp");
    }
}
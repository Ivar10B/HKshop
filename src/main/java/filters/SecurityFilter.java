package filters;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import bean.User;
import java.io.IOException;

public class SecurityFilter implements Filter {

    public void init(FilterConfig config) throws ServletException {}

    public void doFilter(ServletRequest req,
                         ServletResponse res,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  request  = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        // Get the full URL path
        String uri = request.getRequestURI();

        // ✅ Only check Admin pages — ignore everything else
        if (uri.contains("/Admin/")) {

            HttpSession session = request.getSession(false);

            // Not logged in
            if (session == null ||
                session.getAttribute("user") == null) {
                response.sendRedirect(
                    request.getContextPath() +
                    "/Hkshop/login1.jsp?error=2");
                return;
            }

            // Logged in but not admin
            User u = (User) session.getAttribute("user");
            if (!u.getRole().equals("admin")) {
                response.sendRedirect(
                    request.getContextPath() +
                    "/Hkshop/login1.jsp?error=2");
                return;
            }

            // ✅ Is admin — allow through
            chain.doFilter(request, response);
            return;
        }

        // ✅ Not an Admin URL — always allow through
        chain.doFilter(request, response);
    }

    public void destroy() {}
}
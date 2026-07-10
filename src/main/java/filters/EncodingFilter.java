package filters;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import java.io.IOException;

public class EncodingFilter implements Filter {

    public void init(FilterConfig config) throws ServletException {
        // nothing needed here
    }

    public void doFilter(ServletRequest request,
                         ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        // Set encoding BEFORE anything is read or written
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        // Continue to next filter or servlet
        chain.doFilter(request, response);
    }

    public void destroy() {
        // nothing needed here
    }
}
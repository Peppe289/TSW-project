package org.dinosauri.dinosauri.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import org.dinosauri.dinosauri.model.*;

import java.io.*;

@WebFilter(filterName = "/AdminFilter", urlPatterns = {"/adminControl", "/editid", "/removeAdmin", "/addAdmin", "/changePermission"})
public class AdminFilter extends HttpServlet implements Filter {

    /**
     * Don't remove. We need some log for important stuff.
     *
     * @param id - id of admin
     */
    private void notifyConsole(String id) {
        System.out.println("Admin: " + id + " get access to admin page.");
    }

    /**
     * If admin has permission, 1 can modify edit product, see other pages, but con't remove/add admin.
     * If admin has permission, 2 can only access to admin page use "adminControll" uri and edit product.
     * @param url - url access
     * @param permission - admin permission
     * @return - boolean for allowing or not access.
     */
    private boolean checkValidity(String url, int permission) {
        return (permission == 1 && !(url.contains("changePermission") || url.contains("removeAdmin") || url.contains("addAdmin"))) || (permission == 2 && (url.contains("editid") || url.contains("adminControl")));
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest req = (HttpServletRequest) request;

        HttpSession session = req.getSession(false);

        /* if a user isn't in session, check if admin is in. */
        if (session == null || session.getAttribute("admin") == null) {
            ((HttpServletResponse) response).sendRedirect("index.jsp");
            return;
        }

        int permission = AdminDAO.doRetrieveAdminLevelByID((String)session.getAttribute("admin"));

        if (permission == 0) {
            notifyConsole((String)session.getAttribute("admin"));
            chain.doFilter(request, response);
        } else if (checkValidity(req.getRequestURI(), permission)) {
            chain.doFilter(request, response);
            return;
        } else {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"status\":\"Permission denied\"}");
        }

    }
}
package org.dinosauri.dinosauri.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

import java.io.*;

@WebFilter(filterName = "/AdminFilter", urlPatterns = {"/adminControl"})
public class AdminFilter extends HttpServlet implements Filter {
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest req = (HttpServletRequest) request;

        HttpSession session = req.getSession(false);

        /* if a user isn't in session, check if admin is in. */
        if (session == null || session.getAttribute("admin") == null) {
            ((HttpServletResponse) response).sendRedirect("index.jsp");
            return;
        }

        chain.doFilter(request, response);
    }
}
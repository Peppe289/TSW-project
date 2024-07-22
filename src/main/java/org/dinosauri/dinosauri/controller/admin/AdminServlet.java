package org.dinosauri.dinosauri.controller.admin;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import org.dinosauri.dinosauri.model.*;
import org.dinosauri.dinosauri.model.admin.*;

import java.io.*;
import java.sql.*;
import java.util.*;

@WebServlet("/adminControl")
public class AdminServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        doGet(req, resp);
    }

    private void logout(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session != null) session.invalidate();

        resp.sendRedirect(req.getContextPath() + "/");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String reason = req.getParameter("reason");
        int permission = AdminDAO.doRetrieveAdminLevelByID((String) req.getSession().getAttribute("admin"));

        switch (reason) {
            case "user" -> {
                if (permission != 2) users(req, resp);
                else products(req, resp);
            }
            case "admin" -> {
                if (permission != 2) admin(req, resp);
                else products(req, resp);
            }
            case "logout" -> logout(req, resp);
            case "offers" -> {
                if (permission != 2) {
                    RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/admin/manageOffers.jsp");
                    dispatcher.forward(req, resp);
                } else {
                    products(req, resp);
                }
            }
            case null, default -> products(req, resp);
        }
    }

    protected void admin(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        try {
            List<Admin> admins = AdminDAO.doRetrieveAllAdmin();

            req.setAttribute("admins", admins);
            RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/admin/manageAdmin.jsp");
            dispatcher.forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    protected void products(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        List<Product> products = ProductDAO.doRetrieveProducts();

        for (Product product : products) {
            product.setQuantity(ProductDAO.doRetrieveProductByID(product.getId(), true).size());
            product.setBought(ProductDAO.doRetrieveProductByID(product.getId(), false).size());
        }

        req.setAttribute("products", products);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/admin/manageProduct.jsp");
        dispatcher.forward(req, resp);
    }

    protected void users(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        List<User> users = UserDAO.doRetrieveAllUsers();

        req.setAttribute("users", users);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/admin/manageUser.jsp");
        dispatcher.forward(req, resp);
    }
}
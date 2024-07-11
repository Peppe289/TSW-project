package org.dinosauri.dinosauri.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import org.dinosauri.dinosauri.model.*;

import java.io.*;
import java.sql.*;
import java.util.*;

@WebServlet("/adminControl")
public class AdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String reason = req.getParameter("reason");

        switch (reason) {
            case "user" -> users(req, resp);
            case "admin" -> admin(req, resp);
            default -> {
                products(req, resp);
            }
        }
    }

    protected void admin(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        try {
            List<Admin> admins = AdminDAO.doRetrieveAllAdmin();

            req.setAttribute("admins", admins);
            RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/admin/manageAdmin.jsp");
            dispatcher.forward(req, resp);
        } catch (SQLException e) {
            e.printStackTrace();
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
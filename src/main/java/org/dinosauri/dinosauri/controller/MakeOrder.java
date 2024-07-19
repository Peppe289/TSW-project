package org.dinosauri.dinosauri.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import org.dinosauri.dinosauri.model.*;

import java.sql.*;
import java.util.*;

@WebServlet("/make_order")
public class MakeOrder extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        HashMap<String, Integer> products = CarrelloDAO.doRetrieveAllIDFromUser(Integer.parseInt(user.getId()));
        HashMap<Integer, Double> saveForDatabase = new HashMap<>();

        if (products == null) {
            throw new ServletException("You joke me?");
        }

        for (Map.Entry<String, Integer> entry : products.entrySet()) {
            Product product = ProductDAO.doRetrieveProductByID(entry.getKey());
            List<Integer> elements = ProductDAO.doRetrieveProductByID(entry.getKey(), true);
            for (int i = 0; i < elements.size() && i < entry.getValue(); ++i) {
                saveForDatabase.put(elements.get(i), product.getPrice() * (1 - ((double) product.getSconto() / 100)));
            }
        }

        try {
            OrdineDAO.convalidateOrder(Integer.parseInt(user.getId()), saveForDatabase);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        doPost(request, response);
    }
}

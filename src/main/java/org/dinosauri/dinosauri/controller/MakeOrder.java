package org.dinosauri.dinosauri.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import org.dinosauri.dinosauri.model.*;

import java.io.*;
import java.sql.*;
import java.util.*;

@WebServlet("/make_order")
public class MakeOrder extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        HashMap<String, Integer> products = CarrelloDAO.doRetrieveAllIDFromUser(Integer.parseInt(user.getId()));
        HashMap<Integer, Double> saveForDatabase = new HashMap<>();
        int remove;
        Address address = (Address) session.getAttribute("address");

        /* if the user try to confirm order without elements. */
        if (products == null) {
            throw new ServletException("You joke me?");
        }

        /* After retrieve elements in cart, get all available elements and put in hashmap with id_elemento and price. */
        for (Map.Entry<String, Integer> entry : products.entrySet()) {
            /* retrieve product info. */
            Product product = ProductDAO.doRetrieveProductByID(entry.getKey());
            /* id of all available elements */
            List<Integer> elements = ProductDAO.doRetrieveProductByID(entry.getKey(), true);

            remove = 0;

            /* put in hashmap until we have this element or user want this element (refer to quantity in cart). */
            for (int i = 0; i < elements.size() && i < entry.getValue(); ++i) {
                saveForDatabase.put(elements.get(i), product.getPrice() * (1 - ((double) product.getSconto() / 100)));
                remove++;
            }

            /* remove element from cart. */
            if (remove > 0) {
                try {
                    CarrelloDAO.doInsertProdByID(Integer.parseInt(user.getId()), product.getId(), entry.getValue() - remove);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        try {
            /*
             * Add into the database from hashmap with id_elemento and price.
             * This grants we have old price always in order history.
             */
            OrdineDAO.convalidateOrder(Integer.parseInt(user.getId()), saveForDatabase, address);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/fakePayment.jsp");
        requestDispatcher.forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}

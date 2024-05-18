package org.dinosauri.dinosauri.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.dinosauri.dinosauri.model.Product;
import org.dinosauri.dinosauri.model.ProductDAO;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("search");

        if (keyword == null) resp.sendError(HttpServletResponse.SC_BAD_REQUEST);

        String[] keywords = keyword.split(" ");

        List<Product> products = new ArrayList<>();
        for (String tmp : keywords) {
            List<Product> list = ProductDAO.doRetriveProducts(tmp);
            for (Product prod : list) {
                if (!products.contains(prod)) {
                    products.add(prod);
                }
            }
            list.clear();
        }

        req.setAttribute("lastSearch", keyword);
        req.setAttribute("products", products);
        RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/productsList.jsp");
        rd.forward(req, resp);
    }
}

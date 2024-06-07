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

@WebServlet(name = "search", urlPatterns = {"/search", "/product"})
public class SearchServlet extends HttpServlet {

    final public int max_prod_page = 10;

    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("search");
        String page = req.getParameter("page");
        List<Product> products;
        if (page == null) page = "0";

        //Viene chiamata la servlet come search. In questo caso cerca dal pattern.
        if (keyword != null) {
            String[] keywords = keyword.split(" ");

            products = new ArrayList<>();
            for (String tmp : keywords) {
                List<Product> list = ProductDAO.doRetriveProducts(tmp);
                for (Product prod : list) {
                    if (!products.contains(prod)) {
                        products.add(prod);
                    }
                }
                list.clear();
            }
        } else {
            //Viene chiamata la servlet come lista prodotti. In questo caso ci servono tutti i prodotti.
            products = ProductDAO.doRetriveProducts();
        }

        int min = max_prod_page * Integer.parseInt(page);
        int max = max_prod_page + (max_prod_page * Integer.parseInt(page));

        // assicurati di non uscire dagli index
        if (max >= products.size()) max = products.size();

        // Unico modo decente per partizionare gli elementi e far vedere il numero di pagine esatte.
        int btn_page = (int) Math.ceil((double) products.size() / max_prod_page) - 1;
        products = products.subList(min, max);

        if (btn_page < 0) btn_page = 0;

        req.setAttribute("page", page);
        req.setAttribute("btn_page", btn_page);
        req.setAttribute("lastSearch", keyword);
        req.setAttribute("products", products);
        RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/productsList.jsp");
        rd.forward(req, resp);
    }
}

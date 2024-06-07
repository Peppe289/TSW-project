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

@WebServlet("/p")
public class ProductServlet extends HttpServlet {


    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id_prodotto = req.getParameter("product");

        if (id_prodotto == null) resp.sendError(HttpServletResponse.SC_BAD_REQUEST);

        Product product = ProductDAO.doRetrieveProductByID(id_prodotto);

        assert product != null;
        product.setQuantity(ProductDAO.doRetrieveProductByID(id_prodotto, true).size());

        req.setAttribute("product", product);
        RequestDispatcher rd = req.getRequestDispatcher("WEB-INF/product.jsp");
        rd.forward(req, resp);
    }

    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

}

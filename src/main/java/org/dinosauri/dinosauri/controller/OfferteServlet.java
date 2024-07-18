package org.dinosauri.dinosauri.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import org.dinosauri.dinosauri.model.*;

import java.io.*;
import java.util.*;

@WebServlet("/offerte")
public class OfferteServlet extends HttpServlet {


    /* save all paths of image. */
    private void addImage(List<Product> products) {
        for(Product product : products) {
            product.SaveFileList(new File(getServletContext().getRealPath("/")).getAbsolutePath());
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> products = new ArrayList<>();

        products = ProductDAO.doRetrieveProducts();

        /* remove all elements without a sale. */
        List<Product> filtered = products.stream().filter(b -> b.getSconto() != 0).toList();

        /* only for this page use product description as offer description. */
        for (Product prod : filtered) {
            prod.setDescription(OfferteDAO.getOfferDescriptionFromID(prod.getId()));
        }

        /* add an image path to all of this product. */
        addImage(filtered);

        request.setAttribute("products", filtered);
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/offerte.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}

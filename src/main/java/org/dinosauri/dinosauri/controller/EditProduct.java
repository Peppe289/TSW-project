package org.dinosauri.dinosauri.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import org.dinosauri.dinosauri.model.*;

import java.io.*;

@WebServlet("/editid")
public class EditProduct extends HttpServlet {
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String id = req.getParameter("id");

        if (id == null) {
            Product product = new Product();
            req.setAttribute("newProd", true);
            req.setAttribute("product", product);
        } else {
            Product prod = ProductDAO.doRetrieveProductByID(id);
            prod.SaveFileList(new File(getServletContext().getRealPath("/")).getAbsolutePath());
            prod.setQuantity(ProductDAO.doRetrieveProductByID(id, true).size());

            req.setAttribute("product", prod);
        }
        RequestDispatcher rd = req.getRequestDispatcher("WEB-INF/updateProduct.jsp");
        rd.forward(req, resp);
    }

    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        doGet(req, resp);
    }
}

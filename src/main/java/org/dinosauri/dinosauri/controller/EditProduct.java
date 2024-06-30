package org.dinosauri.dinosauri.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.dinosauri.dinosauri.model.Product;
import org.dinosauri.dinosauri.model.ProductDAO;
import org.dinosauri.dinosauri.model.utils.FileManager;

import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet("/editid")
public class EditProduct extends HttpServlet {
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String id = req.getParameter("id");
        if (id == null) {
            throw new RuntimeException("Errore");
        }

        Product prod = ProductDAO.doRetrieveProductByID(id);
        prod.SaveFileList(new File(getServletContext().getRealPath("/")).getAbsolutePath());
        prod.setQuantity(ProductDAO.doRetrieveProductByID(id, true).size());

        req.setAttribute("product", prod);
        RequestDispatcher rd = req.getRequestDispatcher("WEB-INF/updateProduct.jsp");
        rd.forward(req, resp);
    }

    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        doGet(req, resp);
    }
}

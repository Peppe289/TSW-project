package org.dinosauri.dinosauri.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.dinosauri.dinosauri.model.Product;
import org.dinosauri.dinosauri.model.ProductDAO;

import java.io.*;
import java.util.List;

/**
 * Usa la path root /
 */
@WebServlet("/requestIndexProduct")
public class IndexServlet extends HttpServlet {

    private static final Logger logger = LogManager.getLogger(IndexServlet.class);

    /* save all paths of image. */
    private void addImage(List<Product> products) {
        for(Product product : products) {
            product.SaveFileList(new File(getServletContext().getRealPath("/")).getAbsolutePath());
        }
    }

    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        List<Product> products = ProductDAO.doRetrieveProducts();
        ObjectMapper objectMapper = new ObjectMapper();
        String jsonArray = "";
        /* nella pagina index non vogliamo mostrare più di 5 prodotti */
        if (products.size() > 5) products = products.subList(0, 5);

        addImage(products);

        try {
            jsonArray = objectMapper.writeValueAsString(products.toArray());
        } catch (JsonProcessingException e) {
            logger.error("An error occurred while creating json", e);
        }

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(jsonArray);
    }

    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        doGet(req, resp);
    }

}

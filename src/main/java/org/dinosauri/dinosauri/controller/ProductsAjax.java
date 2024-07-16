package org.dinosauri.dinosauri.controller;

import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import org.dinosauri.dinosauri.model.*;

import java.io.*;
import java.util.*;

@WebServlet("/products-json")
public class ProductsAjax extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String json =  null;
        String reason = request.getParameter("reason");
        ObjectMapper mapper = new ObjectMapper();

        switch (reason) {
            case "cat" -> {
                List<String> cat = ProductDAO.doRetrieveCategories();
                json = mapper.writeValueAsString(cat);
            }
            case "nut" -> {
                List<String> nut = ProductDAO.doRetrieveNutrition();
                json = mapper.writeValueAsString(nut);
            }
            case null, default -> {
                List<Product> products = ProductDAO.doRetrieveProducts();
                json = mapper.writeValueAsString(products);
            }
        }

        response.setContentType("application/json");
        response.getWriter().print(json);
    }
}

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
        List<Product> products = ProductDAO.doRetrieveProducts();
        ObjectMapper mapper = new ObjectMapper();
        String json = mapper.writeValueAsString(products);
        response.setContentType("application/json");
        response.getWriter().print(json);
    }
}

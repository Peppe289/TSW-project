package org.dinosauri.dinosauri.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import org.dinosauri.dinosauri.model.*;

import java.util.*;

@WebServlet(name = "init", urlPatterns = "/init-servlet", loadOnStartup = 0)
public class InitServlet extends HttpServlet {
    /**
     * Try and init connect to database.
     */
    public void init(ServletConfig config) {
        HashMap<String, Integer> hashMap = new HashMap<>();
        List<String> categories = ProductDAO.doRetrieveCategories();
        List<String> nutritions = ProductDAO.doRetrieveNutrition();

        for (String category : categories) {
            boolean temp = ProductDAO.doRetrieveNIFutritionByCategory(category);
            if (temp) {
                hashMap.put(category, 1);
                System.out.println("Category: " + category + " has nutritions");
            } else {
                hashMap.put(category, 0);
                System.out.println("Category: " + category + " has no nutritions");
            }
        }

        /* for some reason in this list will appear also "null" string */
        nutritions.remove(null);

        config.getServletContext().setAttribute("categories", hashMap);
        config.getServletContext().setAttribute("nutritions", nutritions);
    }
}

package org.dinosauri.dinosauri.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import org.dinosauri.dinosauri.model.*;

import java.sql.*;

@WebServlet(name = "init", urlPatterns = "/init-servlet", loadOnStartup = 0)
public class InitServlet extends HttpServlet {
    /**
     * Try and init connect to database.
     */
    public void init(ServletConfig config) {
        getServletContext().setAttribute("categories", ProductDAO.doRetrieveCategories());
        getServletContext().setAttribute("nutrition", ProductDAO.doRetrieveNutrition());
    }
}

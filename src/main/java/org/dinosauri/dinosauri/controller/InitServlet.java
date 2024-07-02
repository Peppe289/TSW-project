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
        try {
            ConnectionService.getConnection();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}

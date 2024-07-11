package org.dinosauri.dinosauri.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import org.dinosauri.dinosauri.model.*;

import java.io.*;

@WebServlet("/adminLogIn")
public class AdminLogIn extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String password = request.getParameter("password");

        if (AdminDAO.authenticate(id, password)) {
            HttpSession session = request.getSession();
            session.setAttribute("id", id);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/adminControl");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect("index.jsp");
        }
    }

    /* Do nothing with doGet. */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}

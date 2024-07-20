package org.dinosauri.dinosauri.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import org.dinosauri.dinosauri.model.*;

import java.io.*;


@WebServlet("/user_page")
public class UserPage extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        Address address = AddressDAO.doRetrieveAddress(Integer.parseInt(user.getId()));

        if (address == null) {
            RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/address_page");
            requestDispatcher.forward(req, resp);
            return;
        }

        req.setAttribute("address", address);
        RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/WEB-INF/user.jsp");
        requestDispatcher.forward(req, resp);
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}

package org.dinosauri.dinosauri.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import org.dinosauri.dinosauri.model.*;

import java.io.*;
import java.util.*;


@WebServlet("/user_page")
public class UserPage extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        Address address = AddressDAO.doRetrieveAddress(Integer.parseInt(user.getId()));
        String reason = req.getParameter("reason");
        String id = user.getId();
        List<Ordine> ordineList = OrdineDAO.doRetrieveOrderListInfo(Integer.parseInt(id));

        if (address == null) {
            RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/address_page");
            requestDispatcher.forward(req, resp);
            return;
        }

        req.setAttribute("address", address);
        req.setAttribute("orderList", ordineList);

        if (reason == null) {
            RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/WEB-INF/user.jsp");
            requestDispatcher.forward(req, resp);
        } else if (reason.equals("changeInfo")) {
            String name = req.getParameter("nome");
            String cognome = req.getParameter("surname");
            String email = req.getParameter("email");
            String password = req.getParameter("password");

            if (!((name != null && !name.trim().isEmpty()) &&
                    (cognome != null && !cognome.trim().isEmpty()) &&
                    (email != null && !email.trim().isEmpty()))) {

                req.setAttribute("message", "Campi non validi");
                RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/WEB-INF/user.jsp");
                requestDispatcher.forward(req, resp);
                return;
            }

            User updated = new User();
            updated.setId(id);
            updated.setNome(name);
            updated.setCognome(cognome);
            updated.setEmail(email);

            if (password == null || password.trim().isEmpty()) {
                UserDAO.doUpdateUserByID(updated);
            } else {
                if (!password.contains(" ") && password.length() >= 8)
                    UserDAO.doUpdateUserByID(updated, password);
                else {
                    req.setAttribute("message", "password non valida.");
                    RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/WEB-INF/user.jsp");
                    requestDispatcher.forward(req, resp);
                }
            }
        } else {
            req.setAttribute("message", "Campi non validi");
            RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/WEB-INF/user.jsp");
            requestDispatcher.forward(req, resp);
        }

        user = UserDAO.doRetrieveUserFromID(id);
        session.setAttribute("user", user);
        RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/WEB-INF/user.jsp");
        requestDispatcher.forward(req, resp);
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}

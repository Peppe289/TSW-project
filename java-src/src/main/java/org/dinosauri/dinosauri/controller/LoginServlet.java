package org.dinosauri.dinosauri.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.dinosauri.dinosauri.model.User;
import org.dinosauri.dinosauri.model.UserDAO;

import java.io.IOException;

/**
 * Con il metodo post al login/registazione i dati vengono passati in questa
 * servlet che si occupa di validare la sessione ed aggiungere informazioni personali.
 *
 * Inoltre si occupa di gestire anche il database per la parte utente.
 */
@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {

    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String passowrd = req.getParameter("password");

        if (email == null || passowrd == null) {
            throw new ServletException("Nome and password are required");
        }

        UserDAO userDAO = new UserDAO();
        /**
         * Se il ritorno è null allora non è stato trovato nessun utente con queste caratteristiche.
         * Se il ritorno non è null allora siamo riusciti a creare l'oggetto User.
         */
        User user = userDAO.doRetrieveUser(email, passowrd);
        if (user == null) {
            req.setAttribute("message", "Password o email errati");
            RequestDispatcher rd = req.getRequestDispatcher("login.jsp");
            rd.forward(req, resp);
        }

        req.getSession().setAttribute("user", user);
        RequestDispatcher rd = req.getRequestDispatcher("index.jsp");
        rd.forward(req, resp);
    }

    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

}

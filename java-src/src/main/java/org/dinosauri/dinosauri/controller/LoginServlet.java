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
import java.sql.SQLException;

/**
 * Con il metodo post al login/registazione i dati vengono passati in questa
 * servlet che si occupa di validare la sessione ed aggiungere informazioni personali.
 * Inoltre si occupa di gestire anche il database per la parte utente.
 */
@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {

    private User register(String nome, String cognome, String email, String password) throws SQLException {
        User user = null;
        UserDAO userDAO = new UserDAO();
        user = userDAO.insertInDatabase(nome, cognome, email, password);
        return user;
    }

    private User login(String email, String password) {
        User user = null;
        UserDAO userDAO = new UserDAO();
        user = userDAO.doRetrieveUser(email, password);
        return user;
    }

    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String nome = req.getParameter("nome");
        String cognome = req.getParameter("cognome");
        User user = null;
        String button = req.getParameter("button");

        switch (button) {
            case "registrazione":
                if (email.isEmpty() || password.isEmpty() || nome.isEmpty() || cognome.isEmpty()) {
                    req.setAttribute("message", "I campi sono richiesti");
                    req.getRequestDispatcher("/registrazione.jsp").forward(req, resp);
                }
                try {
                    user = register(nome, cognome, email, password);
                } catch (SQLException e) {
                    if (e.getMessage().contains("Duplicate entry")) req.setAttribute("message", "Email già in uso");
                    else req.setAttribute("message", e.getMessage());

                    req.getRequestDispatcher("/registrazione.jsp").forward(req, resp);
                }
                break;
            case "login":
                if (email.isEmpty() || password.isEmpty()) {
                    req.setAttribute("message", "I campi sono richiesti");
                    req.getRequestDispatcher("/login.jsp").forward(req, resp);
                }
                user = login(email, password);
                break;
            default:
                throw new ServletException("Bruh");
        }

        if (user == null) {
            String page = button.equals("login") ? "login" : "registrazione";
            req.setAttribute("message", "Errore di " + page);
            req.getRequestDispatcher("/" + page + ".jsp").forward(req, resp);
        }

        /**
         * Crea la sessione con i dati dell'utente. i dati verrano visti
         * nella barra di navigazione e nelle specifiche pagine.
         */
        req.getSession().setAttribute("user", user);
        RequestDispatcher rd = req.getRequestDispatcher("/");
        rd.forward(req, resp);
    }

    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

}

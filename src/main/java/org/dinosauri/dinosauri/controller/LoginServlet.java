package org.dinosauri.dinosauri.controller;

import jakarta.ejb.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import org.dinosauri.dinosauri.model.*;
import org.dinosauri.dinosauri.model.utils.*;

import java.io.*;
import java.sql.*;
import java.time.*;
import java.time.format.*;
import java.util.*;

/**
 * Con il metodo post al login/registazione i dati vengono passati in questa
 * servlet che si occupa di validare la sessione ed aggiungere informazioni personali.
 * Inoltre si occupa di gestire anche il database per la parte utente.
 */
@WebServlet("/login-validate")
public class LoginServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        super.init();
        getServletContext().setAttribute("registerCount", 0);
    }

    private User register(String nome, String cognome, String email, String password) throws SQLException {
        return UserDAO.insertInDatabase(nome, cognome, email, password);
    }

    private User login(String email, String password) {
        return UserDAO.doRetrieveUser(email, password);
    }

    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String nome = req.getParameter("nome");
        String cognome = req.getParameter("cognome");
        String stayLogged = req.getParameter("stay_connect");
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
                    //Contatore di persone registrate
                    int registerCount = (int) getServletContext().getAttribute("registerCount");
                    registerCount++;
                    getServletContext().setAttribute("registerCount", registerCount);
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

        if (stayLogged != null) {
            /* create random string for crypt time and save in cookie. */
            Cookie user_id = new Cookie("user_id", user.getId());

            String key = RandomString.generate();
            try {
                /* create cookie with encrypted data and save random kay to database. */
                AccessToken accessToken = new AccessToken(key);
                AccessTokenDAO.doInsertUserToken(user.getId(), accessToken);
                LocalDateTime dateTime = LocalDateTime.now();
                String formattedDateTime = dateTime.toString();

                Cookie token = new Cookie("token", accessToken.encrypt(formattedDateTime));
                user_id.setPath("/");
                user_id.setMaxAge(60 * 60 * 24 * 3);
                resp.addCookie(user_id);
                /* set max age to 3 day */
                token.setPath("/");
                token.setMaxAge(60 * 60 * 24 * 3);
                resp.addCookie(token);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }


        // Crea la sessione con i dati dell'utente. i dati verrano visti nella barra di navigazione e nelle specifiche pagine.
        req.getSession().setAttribute("user", user);
        RequestDispatcher rd = req.getRequestDispatcher("/");
        rd.forward(req, resp);
    }

    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

}

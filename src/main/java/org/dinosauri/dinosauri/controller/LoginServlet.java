package org.dinosauri.dinosauri.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import org.dinosauri.dinosauri.model.*;
import org.dinosauri.dinosauri.model.utils.*;

import java.io.*;
import java.sql.*;
import java.time.*;
import java.util.*;
import java.util.regex.*;

/**
 * Using the POST method for login/registration, the data is passed to this
 * servlet, which is responsible for validating the session and adding personal information.
 * Additionally, it manages the database for the user side.
 */
@WebServlet("/login-validate")
public class LoginServlet extends HttpServlet {
    public static final String prefix = "PRODUCT_";

    private User register(String nome, String cognome, String email, String password) throws SQLException {
        return UserDAO.insertInDatabase(nome, cognome, email, password);
    }

    private User login(String email, String password) {
        return UserDAO.doRetrieveUser(email, password);
    }

    private void loadProdFromSession(HttpServletRequest req) {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        Enumeration<String> sessionEl = session.getAttributeNames();
        HashMap<String, Integer> map = CarrelloDAO.doRetrieveAllIDFromUser(Integer.parseInt(user.getId()));

        while (sessionEl.hasMoreElements()) {
            String id_el = sessionEl.nextElement();
            if (id_el.indexOf(prefix) == 0) {
                int el = (Integer) session.getAttribute(id_el);
                id_el = id_el.replace(prefix, "");
                if (map != null && (map.get(id_el) == null || el > map.get(id_el))) {
                    try {
                        CarrelloDAO.doInsertProdByID(Integer.parseInt(user.getId()), id_el, el);
                    } catch (SQLException ignore) {}
                }
            }
        }
    }

    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String nome = req.getParameter("nome");
        String cognome = req.getParameter("cognome");
        String stayLogged = req.getParameter("stay_connect");
        User user;
        String button = req.getParameter("button");
        String page = button.equals("login") ? "login" : "registrazione";
        /* ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$ */
        Pattern emailPattern = Pattern.compile("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$", Pattern.CASE_INSENSITIVE);

        /* Check for valid input. The user should use the right email format. */
        if (!(email != null && emailPattern.matcher(email).find()) || !(password != null && !password.contains(" ") && password.length() >= 8)) {
            req.setAttribute("message", "Errore di " + page);
            req.getRequestDispatcher("/" + page + ".jsp").forward(req, resp);
            return;
        }

        switch (button) {
            case "registrazione":
                /* need for registration. */
                if (nome.isEmpty() || cognome.isEmpty()) {
                    req.setAttribute("message", "I campi sono richiesti");
                    req.getRequestDispatcher("/registrazione.jsp").forward(req, resp);
                    return;
                }
                try {
                    /*
                     * do insert for register user.
                     * this can generate SQLException.
                     * in this case, create message error and send to request.
                     * the error can be generated for generic error or email already
                     * used.
                     * (unique in a database)
                     */
                    user = register(nome, cognome, email, password);
                } catch (SQLException e) {
                    if (e.getMessage().contains("Duplicate entry")) req.setAttribute("message", "Email già in uso");
                    else req.setAttribute("message", e.getMessage());

                    req.getRequestDispatcher("/registrazione.jsp").forward(req, resp);
                    return;
                }
                break;
            case "login":
                /* try to retrieve user. if failed, return null. the next step will manage this error. */
                user = login(email, password);
                break;
            default:
                throw new ServletException();
        }

        /* if no user results after query/insert, some wrong stuff happened. return with error. */
        if (user == null) {
            req.setAttribute("message", "Errore di " + page);
            req.getRequestDispatcher("/" + page + ".jsp").forward(req, resp);
            return;
        }

        /*
         * staylogged button is checkbox.
         * in this case, save token for login into a database using
         * key encrypt for local data.
         * save the key and for next login do decrypt and check
         * if data (present in token) is valid.
         */
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
                user_id.setSecure(true);
                user_id.setMaxAge(60 * 60 * 24 * 3);
                resp.addCookie(user_id);
                /* set max age to day 3. */
                token.setPath("/");
                token.setSecure(true);
                token.setMaxAge(60 * 60 * 24 * 3);
                resp.addCookie(token);
            } catch (Exception ignore) {
            }
        }

        /* create the session with user data. */
        req.getSession().setAttribute("user", user);
        loadProdFromSession(req);
        resp.sendRedirect(req.getContextPath() + "/");
    }
}

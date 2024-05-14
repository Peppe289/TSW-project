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

    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String nome = req.getParameter("nome");
        String cognome = req.getParameter("cognome");

        if (email == null || password == null) {
            throw new ServletException("Nome and password are required");
        }

        UserDAO userDAO = new UserDAO();
        /**
         * Se il ritorno è null allora non è stato trovato nessun utente con queste caratteristiche.
         * Se il ritorno non è null allora siamo riusciti a creare l'oggetto User.
         *
         * NOTE:    Se anche i dati come nome e cognome sono null allora siamo in login.
         *          Se invece questi campi non sono null, siamo nella registrazione.
         *
         * Il ritorno null di user indica che non è stato strovato alcun utente con quelle
         * credenziali.
         */
        User user = userDAO.doRetrieveUser(email, password);
        if (user == null && (nome == null || cognome == null)) {
            /* errore nel login */
            req.setAttribute("message", "Password o email errati");
            RequestDispatcher rd = req.getRequestDispatcher("login.jsp");
            rd.forward(req, resp);
        } else if (nome != null && cognome != null) {
            /* effettua registrazione dell'utente */
            user = new User();
            user.setEmail(email);
            user.setNome(nome);
            user.setCognome(cognome);
            String id;
            try {
                /* inserisci nel database il nuovo utente e ritorna l'id che il database ha assegnato a questo utente */
                id = userDAO.insertInDatabase(nome, cognome, password, email);
                user.setId(id);
            } catch (SQLException e) {
                /**
                 * Errore nella registrazione
                 *
                 * cattura l'errore, prendi il messaggio e controlla il motivo del messaggio.
                 * L'email è unique, quindi se qualcuno si registra con un'altra email nel messaggio
                 * sarà presente "Duplicate entry" quindi è un errore relativo all'utente.
                 * Per qualsiasi altro errore gestisci in modo diverso.
                 */
                String message = e.getMessage();
                if (message.contains("Duplicate entry")) {
                    /* l'errore è relativo alla email già presente */
                    req.setAttribute("message", "Email già esistente");
                    RequestDispatcher rd = req.getRequestDispatcher("registrazione.jsp");
                    rd.forward(req, resp);
                } else {
                    /* TODO: implementare la schermata di errore appropriata */
                    throw new RuntimeException();
                }
            }
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

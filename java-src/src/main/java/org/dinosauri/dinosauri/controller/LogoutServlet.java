package org.dinosauri.dinosauri.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        /**
         * Non creare una nuova sessione se già esiste.
         * Dopo aver vedrificato l'esistenza invalida la sessione.
         *  Tutti i metodi sono consentiti. Altrimenti è necessario controllare con
         * "request.getMethod().equals("GET")".
         */
        HttpSession session = request.getSession(false);
        if (session != null) session.invalidate();

        response.sendRedirect(request.getContextPath() + "/");
    }
}


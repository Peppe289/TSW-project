package org.dinosauri.dinosauri.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import org.dinosauri.dinosauri.model.*;

import java.io.*;

@WebServlet("/address_page")
public class AddressData extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String reason = req.getParameter("reason");
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        Address address_view = null;

        /* only log in user can access in this page. */
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        /*
         * If we change address from order page, we need to put order in session (not persistent).
         * Insead we change address from settings go to edit in the database.
         */
        if (reason != null && reason.equalsIgnoreCase("ORDER")) {
            address_view = (Address) session.getAttribute("address");
            req.setAttribute("btn_message", "Procedi all'ordine");
            req.setAttribute("reason", "ORDER");
        } else {
            req.setAttribute("btn_message", "Aggiorna Indirizzo");
        }

        /*
         * If we need to change only in order,
         * but not have older info about address in session,
         * go anyway in the database to get data.
         * In the other case, go always in the database.
         */
        if (address_view == null) {
            address_view = AddressDAO.doRetrieveAddress(Integer.parseInt(user.getId()));
        }

        /* if also in database are null, set an empty object. */
        if (address_view == null) {
            /* create an empty object. */
            address_view = new Address();
        }

        req.setAttribute("address_resp", address_view);
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/address.jsp");
        requestDispatcher.forward(req, resp);
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}

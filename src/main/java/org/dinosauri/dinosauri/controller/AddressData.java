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
        Address address_view;

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        if (reason != null && reason.equalsIgnoreCase("ORDER")) {
            address_view = (Address) session.getAttribute("address");
            req.setAttribute("btn_message", "Procedi all'ordine");
        } else {
            address_view = AddressDAO.doRetrieveAddress(Integer.parseInt(user.getId()));
            req.setAttribute("btn_message", "Aggiorna Indirizzo");
        }

        if (address_view != null) {
            req.setAttribute("addr_name", address_view.getName());
            req.setAttribute("addr_cognome", address_view.getCognome());
            req.setAttribute("addr_via", address_view.getVia());
            req.setAttribute("addr_cap", address_view.getCap());
            req.setAttribute("addr_prov", address_view.getProvincia());
            req.setAttribute("addr_city", address_view.getComune());
            req.setAttribute("addr_num", address_view.getNumero_civico());
        }

        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/address.jsp");
        requestDispatcher.forward(req, resp);
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}

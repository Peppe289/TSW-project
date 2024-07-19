package org.dinosauri.dinosauri.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import org.dinosauri.dinosauri.model.*;

import java.io.*;

@WebServlet("/change_address")
public class ChangeAddress extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String reason = request.getParameter("reason");
        String name = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String via = request.getParameter("via");
        String comune = request.getParameter("comune");
        String cap = request.getParameter("cap");
        String civico = request.getParameter("civico");
        String provincia = request.getParameter("provincia");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        /* without login don't should become here. */
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/");
        }

        /* check input. */
        if (name == null || name.isEmpty() || cognome == null || cognome.isEmpty() || via == null || via.isEmpty()
                || comune == null || comune.isEmpty() || cap == null || cap.isEmpty() || civico == null || civico.isEmpty()
                || provincia == null || provincia.isEmpty()) {
            request.setAttribute("reason", reason);
            request.setAttribute("message", "Nessun campo deve essere vuoto");
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/address.jsp");
            requestDispatcher.forward(request, response);
            return;
        }
        Address addr = null;
        try {
            addr = new Address(name, cognome, via, Integer.parseInt(cap), provincia, comune, civico);
        } catch (NumberFormatException e) {
            request.setAttribute("reason", reason);
            request.setAttribute("message", "Input non valido. Controlla il cap e riprova.");
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/address.jsp");
            requestDispatcher.forward(request, response);
            return;
        }

        request.getSession().setAttribute("address", addr);

        if (reason.equalsIgnoreCase("ORDER")) {
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/compra");
            requestDispatcher.forward(request, response);
        } else {
            AddressDAO.doUpdateAddress(Integer.parseInt(user.getId()), addr);
            /* TODO: implement user page. */
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/user.jsp");
            requestDispatcher.forward(request, response);
        }
    }
}

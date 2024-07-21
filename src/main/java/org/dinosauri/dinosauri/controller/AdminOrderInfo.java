package org.dinosauri.dinosauri.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import org.dinosauri.dinosauri.model.*;
import org.dinosauri.dinosauri.model.admin.*;

import java.io.*;
import java.util.*;

@WebServlet("/AdminOrderInfo")
public class AdminOrderInfo extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        List<Ordine> ordineList = OrdineDAO.doRetrieveOrderListInfo(Integer.parseInt(id));
        HttpSession session = req.getSession();
        String admin = (String) session.getAttribute("admin");
        User user;

        /* only admin with permission 0 and 1 can be the see order of user. */
        if (admin == null || AdminDAO.doRetrieveAdminLevelByID((String)session.getAttribute("admin")) == 2) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        user = UserDAO.doRetrieveUserFromID(id);

        req.setAttribute("userProfile", user);
        req.setAttribute("orderList", ordineList);
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/admin/AdminOrder.jsp");
        requestDispatcher.forward(req, resp);
    }
}

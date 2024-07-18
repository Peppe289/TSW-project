package org.dinosauri.dinosauri.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import org.dinosauri.dinosauri.model.*;

import java.io.*;
import java.sql.*;
import java.util.*;

@WebServlet("/compra")
public class ConfirmProductServlet  extends HttpServlet {

    private List<ConfirmProd> getOrderForBuy(HttpServletRequest req) {
        List<ConfirmProd> list = new ArrayList<>();
        HttpSession session = req.getSession();
        Enumeration<String> attributes = session.getAttributeNames();
        User user = (User) session.getAttribute("user");

        HashMap<String, Integer> products = CarrelloDAO.doRetrieveAllIDFromUser(Integer.parseInt(user.getId()));
        if (products != null) {
            for (Map.Entry<String, Integer> entry : products.entrySet()) {
                ConfirmProd temp = new ConfirmProd();
                Product product = ProductDAO.doRetrieveProductByID(entry.getKey());
                product.SaveFileList(new File(getServletContext().getRealPath("/")).getAbsolutePath());

                if (product.getPhoto_path().isEmpty())
                    temp.setPhotoPath(null);
                else
                    temp.setPhotoPath(product.getPhoto_path().getFirst());

                if (product.getSconto() == 0) temp.setPrice(product.getPrice());
                else temp.setPrice(product.getPrice() * (1 - ((double) product.getSconto() / 100)));

                temp.setQuantity(entry.getValue());
                temp.setTile(product.getName());
                temp.setId(entry.getKey());
                list.add(temp);
            }
        }

        return list;
    }


    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        List<ConfirmProd> list = getOrderForBuy(req);

        if (list.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/");;
            return;
        }

        req.setAttribute("prodotti", list);
        RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/WEB-INF/acquista.jsp");
        requestDispatcher.forward(req, resp);
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}

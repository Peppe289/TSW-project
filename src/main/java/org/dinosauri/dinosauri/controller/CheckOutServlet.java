package org.dinosauri.dinosauri.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import org.dinosauri.dinosauri.model.*;

import java.io.*;
import java.util.*;
import java.util.stream.*;

@WebServlet("/compra")
public class CheckOutServlet extends HttpServlet {

    private static boolean stringContainsItemFromList(String inputStr, String[] items)
    {
        if (items == null || inputStr == null)
            return false;

        for (String item : items) {
            if (inputStr.equals(item)) {
                return true;
            }
        }
        return false;
    }

    private List<ConfirmProd> getOrderForBuy(HttpServletRequest req) {
        List<ConfirmProd> list = new ArrayList<>();
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        Integer total = 0;
        double price = 0.0;
        String[] id_list = req.getParameterValues("el");
        /* set in session for make_order page. */
        if (id_list != null)
            session.setAttribute("checked", id_list);
        else
            id_list = (String[]) session.getAttribute("checked");

        HashMap<String, Integer> products = CarrelloDAO.doRetrieveAllIDFromUser(Integer.parseInt(user.getId()));
        if (products != null) {
            for (Map.Entry<String, Integer> entry : products.entrySet()) {
                ConfirmProd temp = new ConfirmProd();

                /* skip if isn't checked in cart page. */
                if (!stringContainsItemFromList(entry.getKey(), id_list))
                    continue;

                Product product = ProductDAO.doRetrieveProductByID(entry.getKey());
                product.SaveFileList(new File(getServletContext().getRealPath("/")).getAbsolutePath());

                if (product.getPhoto_path().isEmpty()) temp.setPhotoPath(null);
                else temp.setPhotoPath(product.getPhoto_path().getFirst());

                /* setta direttamente con lo sconto. */
                if (product.getSconto() == 0) temp.setPrice(product.getPrice());
                else temp.setPrice(product.getPrice() * (1 - ((double) product.getSconto() / 100)));

                /* check if whe have required quantity of product. */
                List<Integer> quantity = ProductDAO.doRetrieveProductByID(product.getId(), true);
                if (quantity.isEmpty()) continue;

                /* put the right quantity in case whe need more than available. */
                if (entry.getValue() > quantity.size()) {
                    temp.setQuantity(quantity.size());
                    total += quantity.size();
                    price += temp.getPrice() * quantity.size();
                } else {
                    temp.setQuantity(entry.getValue());
                    total += entry.getValue();
                    price += temp.getPrice() * entry.getValue();
                }

                temp.setTile(product.getName());
                temp.setId(entry.getKey());
                list.add(temp);
            }
        }

        req.setAttribute("price", price);
        req.setAttribute("total", total);
        return list;
    }


    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        Address address_view;

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        List<ConfirmProd> list = getOrderForBuy(req);

        if (list.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        /* this means we need to go in order page after some action in address page. */
        req.setAttribute("reason", "ORDER");

        /* only temporaly address is saved in session. */
        address_view = (Address) session.getAttribute("address");
        if (address_view == null) {
            address_view = AddressDAO.doRetrieveAddress(Integer.parseInt(user.getId()));
        }

        if (address_view != null) {
            req.setAttribute("address_resp", address_view);
        } else {
            RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/address_page");
            requestDispatcher.forward(req, resp);
            return;
        }

        /* remove empty products. */
        list = list.stream().filter(item -> item.getQuantity() != 0).collect(Collectors.toList());

        req.setAttribute("prodotti", list);
        RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/WEB-INF/acquista.jsp");
        requestDispatcher.forward(req, resp);
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}

package org.dinosauri.dinosauri.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import org.dinosauri.dinosauri.model.*;

import java.io.*;


@WebServlet(name = "Cart", urlPatterns = {"/carrello-add-ajax", "/retrieve-cart"})
public class CarrelloServlet extends HttpServlet {

    /**
     * Try to add element to cart using id. Check if is available.
     *
     * @param request - Need for GET param.
     * @param response - Need to add Cookies.
     * @return json string with all elements and single item (from id).
     */
    private String addElementsToCart(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("id");
        Integer howManyProd = 0;
        Integer totalProductCart = 0;
        boolean err = false;
        int max_elements = ProductDAO.doRetrieveProductByID(id, true).size();

        try {
            howManyProd = Integer.parseInt(request.getParameter("add"));
        } catch (NumberFormatException e) {
            /* I don't care about error. Just do nothing */
            howManyProd = 0;
            err = true;
        }

        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(id)) {
                    /* just save number of product for later. skip for now in total counter. */
                    howManyProd += Integer.parseInt(cookie.getValue());
                    continue;
                }

                int temp;
                try {
                    temp = Integer.parseInt(cookie.getValue());
                } catch (NumberFormatException ignored) {
                    continue;
                }

                totalProductCart += temp;
            }
        }

        if (max_elements < howManyProd || err) {
            howManyProd = max_elements;
            err = true;
        }

        /* Check if is logged or not. If isn't logged save data in cookies. If is logged save in database. */
        User user = (User) request.getSession().getAttribute("user");

        if (user != null) {
            /* TODO: insert to database about user. */
        } else {
            Cookie ck = new Cookie(id, howManyProd.toString());
            ck.setMaxAge(-1);
            response.addCookie(ck);
        }

        totalProductCart += howManyProd;
        if (err) {
            return "{\"elements\":\"" + totalProductCart + "\",\"item\":\"" + howManyProd + "\",\"status\":\"Too many element\"}";
        } else {
            return "{\"elements\":\"" + totalProductCart + "\",\"item\":\"" + howManyProd + "\",\"status\":\"success\"}";
        }
    }

    /**
     * Retrive all elements if we use cookies.
     *
     * @param request - get cookies.
     * @return json with number of all elements
     */
    private String doRetriveAllElementsCart(HttpServletRequest request) {
        int totalProductCart = 0;
        // TODO: implement also without cookie for logged user.
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                int temp;
                try {
                    temp = Integer.parseInt(cookie.getValue());
                } catch (NumberFormatException ignored) {
                    continue;
                }

                totalProductCart += temp;
            }
        }

        return "{\"elements\":\"" + totalProductCart + "\",\"status\":\"success\"}";
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String json;
        if (id != null) {
            json = addElementsToCart(request, response);
        } else {
            json = doRetriveAllElementsCart(request);
        }
        response.setContentType("application/json");
        response.getWriter().print(json);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException {
    }
}

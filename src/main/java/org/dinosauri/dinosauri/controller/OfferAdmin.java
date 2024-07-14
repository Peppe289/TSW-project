package org.dinosauri.dinosauri.controller;

import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import org.dinosauri.dinosauri.model.*;

import java.io.*;
import java.sql.*;
import java.sql.Date;
import java.time.*;
import java.util.*;


@WebServlet(name = "offer", urlPatterns = "/offer")
public class OfferAdmin extends HttpServlet {

    /**
     * Remove offer from id.
     *
     * @param request - need to retrieve id.
     * @return - json with status.
     */
    private String removeOffer(HttpServletRequest request) {
        String id = request.getParameter("id");
        String status = "success";

        try {
            OfferteDAO.removeOffer(id);
        } catch (SQLException e) {
            status = "Error";
        }
        return "{\"status\": \""+ status + "\"}";
    }

    /**
     * Make insert of new offers. Validate input and check if all it's ok with the logic of data.
     * Retrieve json as a response to the status of operations.
     *
     * @param request - about servlet parameter
     * @return - json with status.
     * @throws JsonProcessingException - while convert hashmap to json.
     */
    private String insertOffer(HttpServletRequest request) throws JsonProcessingException {
        HashMap<String, String> map = new HashMap<>();
        ObjectMapper mapper = new ObjectMapper();
        String startDate_str = request.getParameter("startDate");
        String endDate_str = request.getParameter("endDate");
        String id = request.getParameter("id_prod");
        String percentage = request.getParameter("percentage");
        LocalDate startDate = LocalDate.parse(startDate_str);
        LocalDate endDate = LocalDate.parse(endDate_str);
        List<Offerta> offs;

        /* check if the date is valid and the range of percentage (offer) is valid. */
        if (!startDate.isBefore(endDate) && !(Integer.parseInt(percentage) > 0 && Integer.parseInt(percentage) <= 99)) {
            map.put("status", "Dati non validi");
            return mapper.writeValueAsString(map);
        }

        /* check data input. */
        if (id != null && !id.isEmpty()) {
            offs = OfferteDAO.doRetrieveOffers(id);
        } else {
            map.put("status", "invalid date");
            return mapper.writeValueAsString(map);
        }

        for (Offerta off : offs) {
            /*
             * Prevent multiple offerts at the same time.
             * If endDate or start date of new input offert is after start date of k-offert and is before end data of k-offert make error.
             */
            boolean endDate_invalid = endDate.isAfter(off.getStartDate().toLocalDate()) && endDate.isBefore(off.getEndDate().toLocalDate());
            boolean startDate_invalid = startDate.isAfter(off.getStartDate().toLocalDate()) && startDate.isBefore(off.getEndDate().toLocalDate());
            if (endDate_invalid || startDate_invalid) {
                map.put("status", "Un'altra offerta è presente in questo periodo.");
                return mapper.writeValueAsString(map);
            }
        }
        Offerta off = new Offerta();

        /* TODO: add description. empty for now */
        off.setDescription("");
        off.setId_prodotto(id);
        off.setStartDate(Date.valueOf(startDate));
        off.setEndDate(Date.valueOf(endDate));
        off.setPercentage(Integer.parseInt(percentage));
        try {
            OfferteDAO.InsertOffers(off);
            map.put("status", "success");
        } catch (SQLException e) {
            map.put("status", "ID error");
        }
        return mapper.writeValueAsString(map);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String json;
        String reason = request.getParameter("reason");
        switch (reason) {
            case "add" -> json = insertOffer(request);
            case "rmove" -> json = removeOffer(request);
            case null, default -> {
                List<Offerta> offers = OfferteDAO.doRetrieveOffers();
                ObjectMapper mapper = new ObjectMapper();
                json = mapper.writeValueAsString(offers.toArray());
            }
        }

        response.setContentType("application/json");
        response.getWriter().print(json);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doPost(request, response);
    }

}

package org.dinosauri.dinosauri.controller;

import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import org.dinosauri.dinosauri.model.*;
import org.dinosauri.dinosauri.model.admin.*;

import java.io.*;
import java.sql.*;
import java.sql.Date;
import java.time.*;
import java.util.*;


@WebServlet(name = "offer", urlPatterns = "/offer")
@SuppressWarnings("unchecked")
public class OfferAdmin extends HttpServlet {

    /**
     * Remove offer from id.
     *
     * @param parameter - need to retrieve id.
     * @return - json with status.
     */
    private String removeOffer(HashMap<String, String> parameter) {
        String id = parameter.get("id");
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
     * @param parameter - about servlet parameter
     * @return - json with status.
     * @throws JsonProcessingException - while convert hashmap to json.
     */
    private String insertOffer(HashMap<String, String> parameter) throws JsonProcessingException {
        HashMap<String, String> map = new HashMap<>();
        ObjectMapper mapper = new ObjectMapper();
        String startDate_str = parameter.get("startDate");
        String endDate_str = parameter.get("endDate");
        String id = parameter.get("id");
        String percentage = parameter.get("percent");
        String description = parameter.get("description");
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
            /* Means: ( s1 < eN < e1 ) || e1 == eN */
            boolean endDate_invalid = (endDate.isAfter(off.getStartDate().toLocalDate()) && endDate.isBefore(off.getEndDate().toLocalDate())) || endDate.isEqual(off.getEndDate().toLocalDate());
            /* Means: ( s1 < sN < e1 ) || s1 == sN */
            boolean startDate_invalid = (startDate.isAfter(off.getStartDate().toLocalDate()) && startDate.isBefore(off.getEndDate().toLocalDate())) || startDate.isEqual(off.getEndDate().toLocalDate());
            /* Means: check if some point (end/start) had the same time with others. */
            boolean equalsPoint_invalid = startDate.isEqual(off.getStartDate().toLocalDate()) || endDate.isEqual(off.getStartDate().toLocalDate());
            if (endDate_invalid || startDate_invalid || equalsPoint_invalid) {
                map.put("status", "Un'altra offerta è presente in questo periodo.");
                return mapper.writeValueAsString(map);
            }
        }
        Offerta off = new Offerta();

        off.setDescription(description);
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
        String json, line;
        StringBuilder req_json = new StringBuilder();
        BufferedReader reader = request.getReader();
        ObjectMapper mapper = new ObjectMapper();
        HashMap<String, String> parameter = new HashMap<>();
        int permission = AdminDAO.doRetrieveAdminLevelByID((String) request.getSession().getAttribute("admin"));

        if (permission == 2) {
            json = "{\"status\": \"Permission Denied\"}";
        } else {
            while ((line = reader.readLine()) != null) {
                req_json.append(line);
            }

            parameter = mapper.readValue(req_json.toString(), HashMap.class);

            switch (parameter.get("reason")) {
                case "add" -> json = insertOffer(parameter);
                case "remove" -> json = removeOffer(parameter);
                case null, default -> {
                    List<Offerta> offers = OfferteDAO.doRetrieveOffers();
                    json = mapper.writeValueAsString(offers.toArray());
                }
            }
        }

        response.setContentType("application/json");
        response.getWriter().print(json);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String json;
        List<Offerta> offers = OfferteDAO.doRetrieveOffers();
        ObjectMapper mapper = new ObjectMapper();
        json = mapper.writeValueAsString(offers.toArray());
        response.setContentType("application/json");
        response.getWriter().print(json);
    }

}

package org.dinosauri.dinosauri.controller;

import com.fasterxml.jackson.databind.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import org.dinosauri.dinosauri.model.*;

import java.io.*;
import java.sql.*;
import java.util.*;


@WebServlet(name = "/manage-admin", urlPatterns = {"/removeAdmin", "/addAdmin", "/changePermission"})
@SuppressWarnings("unchecked")
public class AdminRA extends HttpServlet {

    private String removeAdmin(HashMap<String, String> map) {
        String status;
        status = AdminDAO.deleteAdmin(Integer.parseInt(map.get("id"))) ? "success" : "Error";
        return "{\"status\": \"" + status + "\" }";
    }

    private String addAdmin(HashMap<String, String> map) {
        int id;
        try {
            id = AdminDAO.insertInDatabase(map.get("password"));
        } catch (SQLException e) {
            return null;
        }
        return "{\"id\":" + id + ",\"status\":\"success\"}";
    }

    private String changePermission(HashMap<String, String> map) {
        String status = "success";
        if (!AdminDAO.doUpdatePermissionByID(map.get("id"), Integer.parseInt(map.get("permission")))) {
            status = "error";
        }
        return "{\"status\": \"" + status + "\" }";
    }

    /* allow only doPost */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        StringBuilder stringBuilder = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        ObjectMapper mapper = new ObjectMapper();
        HashMap<String, String> map;
        String result = null;

        HttpSession session = request.getSession();
        String admin = (String) session.getAttribute("admin");

        while ((line = reader.readLine()) != null) {
            stringBuilder.append(line);
        }

        map = mapper.readValue(stringBuilder.toString(), HashMap.class);

        /* Only admin with permission at level 0 can delete/add admin. */
        if (AdminDAO.doRetrieveAdminLevelByID(admin) != 0) {
            result = "{\"status\": \"Permission denied\" }";
        } else if (map.containsKey("id") && map.get("action").equals("removeAdmin") && Integer.parseInt(map.get("id")) > 1) {
            result = removeAdmin(map);
        } else if (map.containsKey("password") && map.get("action").equals("addAdmin") && map.get("password").length() >= 8) {
            result = addAdmin(map);
        } else if (map.containsKey("permission") && map.get("action").equals("modify_perm") && map.containsKey("id")) {
            result = changePermission(map);
        }

        if (result == null || result.isEmpty()) result = "{\"status\": \"error\" }";

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(result);
    }

}

package org.dinosauri.dinosauri.controller;

import com.fasterxml.jackson.databind.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import org.dinosauri.dinosauri.model.utils.FileManager;

import java.io.*;
import java.nio.file.Path;
import java.util.*;

@WebServlet("/uploadimg")
@MultipartConfig
public class UploadImg extends HttpServlet {

    /**
     * This servlet is used for write in server directory the new immage taked from client
     * About this we can consider:
     *
     * @exception IOException if we can't write in that directory, we need to catch this error and return the right status response.
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Part filePart = request.getPart("image");
        String id = request.getParameter("id");
        Path destination = FileManager.getNextDiskPath(id, getServletContext().getRealPath("/"));
        List<File> files;
        List<String> newPath = new ArrayList<>();
        ObjectMapper objectMapper = new ObjectMapper();

        /*
         * Needed for fix this:
         *
         * XML Parsing Error: not well-formed
         * Location: http://localhost:8080/dinosauri_war_exploded/uploadimg?id=OBR
         * Line Number 1, Column 1:
         */
        response.setContentType("application/json");

        try {
            FileManager.createDirectory(destination.getParent());
            /* write file received in the right directory. this can be give IOException. Catch it. */
            FileManager.writeFile(filePart.getInputStream(), destination);
        } catch(IOException e) {
            /* some error happened. send result to client */
            response.setStatus(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
            /* return json page with error status */
            response.getWriter().print("{\"status\":\"I/O Error\"}");
            return;
        }

        /* get update image list */
        files = FileManager.RetriveFileFromID(id, new File(getServletContext().getRealPath("/")).getAbsolutePath());
        for (File file : files) {
            newPath.add(FileManager.directory + "/" + file.getName());
        }

        String jsonPath = objectMapper.writeValueAsString(newPath.toArray());

        /* set status for response to 200 (OK) */
        response.setStatus(HttpServletResponse.SC_OK);
        /* return json page with status success */
        response.getWriter().print("{\"path\": "+ jsonPath + ",\"status\":\"success\"}");

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}

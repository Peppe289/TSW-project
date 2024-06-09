package org.dinosauri.dinosauri.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import org.dinosauri.dinosauri.model.utils.FileManager;

import java.io.IOException;
import java.nio.file.Path;

@WebServlet("/uploadimg")
@MultipartConfig
public class UploadImg extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Part filePart = request.getPart("image");
        String id = request.getParameter("id");
        Path destination;
        destination = FileManager.getNextDiskPath(id, getServletContext().getRealPath("/"));

        FileManager.createDirectory(destination.getParent());
        FileManager.writeFile(filePart.getInputStream(), destination);

        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().print("{\"status\":\"success\"}");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}

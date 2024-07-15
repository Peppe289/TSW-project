package org.dinosauri.dinosauri.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) session.invalidate();
        Cookie[] cookies = request.getCookies();

        /* remove cookies for stay connect. */
        for (Cookie ck : cookies) {
            if (ck.getName().equals("user_id") || ck.getName().equals("token")) {
                ck.setMaxAge(0);
                ck.setSecure(true);
                ck.setValue("");
                ck.setPath("/");
                response.addCookie(ck);
            }
        }

        response.sendRedirect(request.getContextPath() + "/");
    }
}


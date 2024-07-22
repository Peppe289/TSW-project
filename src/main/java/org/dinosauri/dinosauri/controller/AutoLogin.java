package org.dinosauri.dinosauri.controller;


import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import org.dinosauri.dinosauri.model.*;

import java.io.*;
import java.time.*;
import java.time.temporal.*;

/**
 * This filter will do auto login using cookies.
 * First check if cookies are available, then retrieve
 * from client cookies with LocalDataTime encrypted
 * and try to decrypt with a random key in a database.
 */
@WebFilter(filterName = "/AutoLogin", urlPatterns = "/*")
public class AutoLogin extends HttpServlet implements Filter {
    private void loginUsingCookie(HttpServletRequest req) {
        Cookie[] cookies = req.getCookies();
        Cookie token = null;
        String sCookie = null;
        String id = null;
        AccessToken accessToken;

        if (cookies == null) {
            return;
        }
        for (Cookie ck : cookies) {
            if (ck.getName().equals("token")) {
                sCookie = ck.getValue();
                token = ck;
            } else if (ck.getName().equals("user_id")) {
                id = ck.getValue();
            }
        }

        if (sCookie != null && id != null) {
            /* check if the cookie for login is valid or not. */
            accessToken = AccessTokenDAO.doRetrieveUserToken(id);
            if (accessToken != null) {
                String sData = accessToken.decrypt(sCookie);
                LocalDateTime data = LocalDateTime.parse(sData);
                long daysBetween = ChronoUnit.DAYS.between(data, LocalDateTime.now());
                if (daysBetween > 3) {
                    // invalidate this cookie. time expired.
                    token.setSecure(true);
                    token.setMaxAge(0);
                } else {
                    User user = UserDAO.doRetrieveUserFromID(id);
                    req.getSession().setAttribute("user", user);
                }
            }
        }
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession(false);

        /* if a user isn't in session, try to log in using cookie. */
        if (session == null) {
            loginUsingCookie(req);
        } else if (session.getAttribute("user") == null) {
            loginUsingCookie(req);
        }

        chain.doFilter(request, response);
    }
}

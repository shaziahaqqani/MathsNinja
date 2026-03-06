package com.mathsninja;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/start")
public class StartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L; 

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String username = req.getParameter("username");

        HttpSession session = req.getSession();
        session.setAttribute("username", username);
        session.setAttribute("score", 0);

        res.sendRedirect("select.jsp");
    }
}